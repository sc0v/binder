for file in $(ls ./fixtures); do
    name=$(cut -d "." -f 1 <<< $file)
    module_name=""
    num_words=$(tr -dc '_' <<< $name | wc -c)
    for n in $(seq 1 $((num_words+1))); do
        w=$(cut -d "_" -f $n <<< $name)
        module_name+=${w^}
    done
    echo "module Contexts
            module ${module_name}
                def create_${name}

                end

                def destroy_${name}

                end
            end
        end
    " >> ./sets/${name}.rb
    echo "require \"test/sets/${name}\"" >> ./contexts.rb
done