#
# Register a custom subclass of Redcarpet which enabled SmartyPants and Syntax
# Highlighting to render the Markdown based documentation.
#

require "tilt/redcarpet"

class HTMLwithPygments < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

  def block_code(code, language)
    if language.eql? 'headers'
      options = {:cssclass => language}
      language = ''
    end

    Pygments.highlight(code, :lexer => language, :options => options)
  end
end

Tilt.register Tilt::Redcarpet2Template, 'markdown', 'md'
set :markdown, :renderer => HTMLwithPygments, :fenced_code_blocks => true,
                                              :layout_engine => :erb
