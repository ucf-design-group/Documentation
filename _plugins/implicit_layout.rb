module ImplicitLayout
  def read_yaml(*args)
    super
    self.data['layout'] ||= 'default'
  end
end

Jekyll::Post.send(:include, ImplicitLayout)