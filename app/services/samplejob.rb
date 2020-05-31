class SampleJob
    def perform
      begin
        # do all your work in the begin block.
        puts "hello world - teste"
      rescue Exception => e
        # rescue any errors so that you know something went wrong. Email yourself the error if you need.
        error_msg = "#{Time.now} ERROR (SampleJob#perform): #{e.message} - (#{e.class})\n#{(e.backtrace or []).join("\n")}"
        puts error_msg
     
      end
    end
  end