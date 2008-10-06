require 'find'

class Finder
  def initialize
    @directories_to_prune = %w[.git vendor]
    @extensions           = %w[builder css erb haml html icalendar js rake rb yml] + ['']
  end

  def files(directory)
    files = []

    Find.find directory do |path|
      if FileTest.directory? path
        Find.prune if should_prune?(path)
      else
        files.push(path) if should_include?(path)
      end
    end

    files
  end

  private

  def should_include?(path)
    @extensions.include?(File.extname(path).sub(/^\./, ''))
  end

  def should_prune?(path)
    @directories_to_prune.include?(File.basename(path))
  end
end