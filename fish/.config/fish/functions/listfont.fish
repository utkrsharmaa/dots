function listfont --wraps='fc-list | cut -d : -f 2 | cut -d , -f 1 | sort | uniq' --description 'alias listfont=fc-list | cut -d : -f 2 | cut -d , -f 1 | sort | uniq'
  fc-list | cut -d : -f 2 | cut -d , -f 1 | sort | uniq $argv
        
end
