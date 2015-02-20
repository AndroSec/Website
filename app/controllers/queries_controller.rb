class QueriesController < ApplicationController
  protect_from_forgery

  # GET /
  def index
    
  end

  # in light of the unavailability of an easy way to connect to sqlite in a read-only state, 
  # we filter the destructive commands out of the query and run it to return the results as 
  # a partial to show the user
  def create
    # list of mutative commands in sqlite3 we dont want to run on the database
    bad_commands = %w(insert delete vacuum drop alter detach update replace attach reindex attach)

    # if there are no destructive commands, attempt to run the query
    if bad_commands.none? {|cmd| cmd.in? params[:query].downcase}
      begin
        @results = ActiveRecord::Base.connection.execute(params[:query])
        raise "Bad Query" if @results.nil?
        # the result set returned has keys for accessing them as an array,
        # we remove them here
        indexes = @results.first.keys.size / 2
        @results.each do |result|
          indexes.times do |i|
            result.delete(i)
          end
        end
        render partial: "show"
      rescue
        render partial: "show", status: :bad_request
      end
    else
      render partial: "show", status: :bad_request
    end
  end

end