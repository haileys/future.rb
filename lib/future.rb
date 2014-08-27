class Future < Thread
  VERSION = "1.0.0"

  def self.all(futures)
    Future { futures.map(&:value) }
  end

  def to_s
    case status
    when nil
      "#<#{self.class} (errored)>"
    when false
      "#<#{self.class} value=#{value}>"
    else
      "#<#{self.class} (incomplete)>"
    end
  end
end

def Future(&bk)
  Future.start(&bk)
end
