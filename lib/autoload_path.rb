module AutoloadPath
  module_function

  def load_path source_path , *args
    each_file source_path , *args do |file_path|
      load file_path.to_s
    end
  end

  def require_path source_path , *args
    each_file source_path , *args do |file_path,extname|
      require file_path.to_s.gsub(extname, "")
    end
  end

  def get_files source_path , *args
    file_paths = []
    each_file source_path , *args do |file_path|
      file_paths << file_path
    end
    file_paths
  end

  def each_file source_path , *args, &block
    options = args.extract_options!
    raise ArgumentError.new "Most supply a block" unless block_given?
    source_path = Pathname.new(source_path)
    prefix = options[:prefix]
    except = (options[:except] || []).map{|i| i.to_s}
    only = (options[:only] || []).map{|i| i.to_s}
    original_source = options[:original_source] ? Pathname.new(options[:original_source]) : source_path
    Dir.glob(source_path.join("*")).each do |path|
      path = Pathname.new path
      root = path
      parent = path.parent.basename
      actual = path.basename
      if path.directory? 
        each_file path, original_source: original_source , prefix: prefix, except: except, only: only, &block
      else
        if actual == source_path
          file_path = path.relative_path_from(original_source.parent)
          root = original_source.parent 
        else 
          file_path = path.relative_path_from(original_source.parent.parent)
          root = original_source.parent.parent 
        end
        extname = file_path.extname
        if prefix
          file_path = prefix + file_path.to_s 
        else
         file_path = File.join(root,file_path)
        end
        if only.length > 0 
          block.call(file_path, extname) if only.include?(file_path.to_s) && !except.include?(file_path.to_s)
        else
          block.call(file_path, extname) if (!except.include?(file_path.to_s) && !only.include?(file_path.to_s))
        end 
      end
    end          
  end

end
