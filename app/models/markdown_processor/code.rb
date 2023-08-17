class MarkdownProcessor
  class Code
    def self.process(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('pre').each do |pre|
        if pre.children.first.name == "code"
          pre[:class] = "relative group"
          pre["data-controller"] = "code-block"
          pre.inner_html = ApplicationController.renderer.render(partial: "shared/code_block", locals: { code: pre.inner_html })
        end
      end
      doc.css('code[@class]').each do |code|
        code[:class] = "language-" + code[:class]
      end
      doc.to_s
    end
  end
end
