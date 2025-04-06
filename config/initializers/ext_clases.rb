require Rails.root.join('lib', 'hash_ext')
Hash.send(:include, HashExt)
