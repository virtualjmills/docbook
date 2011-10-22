module Docbook
  module Adapters
      
    module Fo
      # Interface for FO-PDF processors, for taking FO output 
      # created by the XML processor and converting it to various formats.
      # The methods in this module

      module Xep
    
        # initialize the object and set the extensions and output type. Defaults to PDF
        def initialize(args = {})
          super
          @xsl_extension = "fo"
        
        end
    
        # Create the command to launch FOP
        def xep_command  
          cmd = "~/xep/xep -fo #{self.file}.fo -format #{@output} #{self.file}.#{@output}"

          cmd.gsub!(";",":") unless @windows
          cmd
        end
    
        def before_render
          xsl_path = @windows ? self.root : self.root.lchop
      
          fo_xml = %Q{<?xml version='1.0'?>

          <!-- DO NOT CHANGE THIS FILE. IT IS AUTOGENERATED BY THE SHORT-ATTENTION-SPAN-DOCBOOK CHAIN -->

          <xsl:stylesheet 
             xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
             xmlns:fo="http://www.w3.org/1999/XSL/Format"
             xmlns:xslthl="http://xslthl.sf.net"
             xmlns:d="http://docbook.org/ns/docbook"
          >
            <!-- Import the original FO stylesheet -->
            <xsl:import href="file:///#{xsl_path}/xsl/fo/docbook.xsl"/>
            <xsl:import href="file:///#{xsl_path}/xsl/fo/highlight.xsl"/>
      
            <!-- XEP -->
            <!-- XEP extensions support -->
            <xsl:param name="xep.extensions">1</xsl:param>
          }
      
          fo_xml << %Q{
            <xsl:param name="show.comments" select="1"></xsl:param>
            <xsl:param name="draft.watermark.image">http://docbook.sourceforge.net/release/images/draft.png</xsl:param>
            <xsl:param name="draft.mode">yes</xsl:param>
          } if @draft
      
          fo_xml << "</xsl:stylesheet>"
      
          File.open("xsl/fo.xml", "w") do |f|
            f << fo_xml
          end
        end
     
        # Callback to build the final file after the XML-FO rendering occurs
        def after_render
          if File.exists?("#{self.file}.fo")
            OUTPUT.say "Building #{@output}"
            output = run_command self.xep_command
            if output.include?("Exception")
              OUTPUT.error "There was a problem converting your book. See fop_error.txt"
              File.open("fop_error.txt", "w"){|f| f << output}
            else
              add_cover if self.respond_to?(:add_cover)
            end
            OUTPUT.say "Cleaning up"
            FileUtils.rm "#{self.file}.fo"
            
            
          else
            OUTPUT.say "FO processing halted - missing #{self.file}.fo file."
          end
        end
        
      end
    end
  end
end