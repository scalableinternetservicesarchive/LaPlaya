if defined? BetterErrors
  BetterErrors.editor = proc { |full_path, line|
    "x-mine://open?file=#{full_path}&line=#{line}"
  }
end