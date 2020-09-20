# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'models/robot'
require 'models/coordinate'
require 'services/direction_to_coordinate'

module Commands
  class Node
    attr_reader :coordinate
    attr_accessor :parent

    def initialize(coordinate, parent)
      @coordinate = coordinate
      @parent = parent
    end

    def valid_children(app)
      robot = app.robot
      obstacles = app.obstacles
      table = app.table

      children.select do |node|
        node.coordinate != robot.coordinate &&
          !obstacles.map(&:coordinate).include?(node.coordinate)&&
          table.contain?(node.coordinate)
      end
    end

    def children
      [
        self.class.new(coordinate + Models::Coordinate.new(0,1), self),
        self.class.new(coordinate + Models::Coordinate.new(1,0), self ),
        self.class.new(coordinate + Models::Coordinate.new(0,-1), self),
        self.class.new(coordinate + Models::Coordinate.new(-1,0), self)
      ]
    end
  end

  class FindPath
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    attr_reader :app, :queue, :visited_queue

    def initialize(app:)
      @app = app
      @queue = []
      @visited_queue = []
    end

    def call(destination:)
      robot = app.robot
      root_node = Node.new(robot.coordinate, nil)
      goal_post = Node.new(destination.coordinate, nil)
      queue <<  root_node
      visited_queue.push root_node

  # 1. Add root node to the queue, and mark it as visited(already explored).
  # 2. Loop on the queue as long as it's not empty.
  #    1. Get and remove the node at the top of the queue(current).
  #    2. For every non-visited child of the current node, do the following: 
  #        1. Mark it as visited.
  #        2. Check if it's the goal node, If so, then return it.
  #        3. Otherwise, push it to the queue.
  # 3. If queue is empty, then goal node was not found!

      result = while queue.size != 0
        root_node = queue.shift

        children = root_node.valid_children(app)

        non_visited_children = children.select { |child| !visited_queue.map(&:coordinate).include? child.coordinate }


        non_visited_children.each { |child| visited_queue.push child }

        if non_visited_children.map(&:coordinate).include? goal_post.coordinate
          destination_node = non_visited_children.find { |child| child.coordinate == goal_post.coordinate }
          break  destination_node
        else
          non_visited_children.each { |child| queue.push child }
        end
      end

      cursor = result
      paths = [result.coordinate]

      while !cursor.nil?
        cursor = cursor.parent
        paths.push cursor&.coordinate
      end

      app.output.puts(paths.compact.map{|coordinate| "#{coordinate.x},#{coordinate.y}"}.join("\n"))

      Success()
    end
  end
end
