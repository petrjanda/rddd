require 'rddd/services/service'

class ListService < Rddd::Services::Service
  def execute
    projects = [
      {
        :name => 'rDDD',
        :deathline => Date.parse('1st Jan 2014'),
        :description => 'Domain driven design framework'
      },

      {
        :name => 'Rails',
        :deathline => Date.parse('1st Jan 2015'),
        :description => 'Most popular Ruby framework'
      }
    ]

    @attributes['name'] ? \
      projects.select {|project| project[:name] == @attributes['name']} : \
      projects
  end
end