# Pretty Inspect Gem

class Object

=begin
  This gem extends Object::inspect to "pretty" inspect
  arrays and hashes.

  Example: (copy this to irb)
    require 'pretty_inspect'
    require 'bigdecimal'
    class X
      def initialize
        @y = BigDecimal(31.41592653589796,4)
        @f = false
        @t = true
        @g = 3.141592653589796
        @n = nil
      end
    end
    puts (['a','b',{1=>'a',2=>X.new},'c'].pretty_inspect)

  Yields:
    [
      "a",
      "b",
      {
        1=>"a",
        2=><X:47374925831780
          @f===false,
          @t===true,
          @g===3.141592653589796,
          @n===nil,
          @y=31.42
        >
      },
      "c"
    ]
=end

  def pretty_inspect(max_level=999)
    object_ids = []
    pretty_inspect_core("", self, 0, "", object_ids, max_level-1)
  end

private

  def pretty_inspect_core(name, values, level, output, object_ids, max_level)
      case values
        when Array
          output << "[\n"
          if (level>>1) > max_level
            output << " "*(level+2)
            output << "et.al.\n"
          else
            count = values.size
            values.each do |value|
              output << " "*(level+2)
              if object_ids.index(value.object_id)
                output << "[%s ...]"%name
              else
                object_ids.push(value.object_id)
                pretty_inspect_core(name, value,level+2,output,object_ids, max_level-1)
                object_ids.pop
              end
              output << (if (count -= 1) > 0 then ",\n" else "\n" end)
            end
          end
          output << " "*level
          output << "]"
        when Hash
          output << "{\n"
          if (level>>1) > max_level
            output << " "*(level+2)
            output << "et.al.\n"
          else
            count = values.size
            values.each do |key,value|
              output << "%s%s=>"%[" "*(level+2),key.inspect]
              if object_ids.index(value.object_id)
                output << "{@%s ...}"%key
              else
                object_ids.push(value.object_id)
                pretty_inspect_core(key, value,level+2,output,object_ids, max_level-1)
                object_ids.pop
              end
              output << (if (count -= 1) > 0 then ",\n" else "\n" end)
            end
          end
          output << " "*level
          output << "}"
        else
          count = values.instance_variables.count
          if count==0
            output << values.inspect
          else
            output << "<%s:%d\n"%[values.class.name,values.object_id]
            if (level>>1) > max_level
              output << " "*(level+2)
              output << "et.al.\n"
            else
              values.instance_variables.each do |item|
                value = values.instance_variable_get(item)
                output << " "*(level+2)
                case
                  when defined?(BigDecimal) && value.class==BigDecimal
                    output << "%s=%s"%[item,value.to_s("F")]
                  when [Complex,FalseClass,Float,Integer,NilClass,Regexp,String,TrueClass].index(value.class)
                    output << "%s=%s"%[item,value.inspect]
                  else
                    output << "%s="%item
                    if object_ids.index(value.object_id)
                      output << "<%s ...>"%item
                    else
                      object_ids.push(value.object_id)
                      pretty_inspect_core(item,value,level+2,output,object_ids, max_level-1)
                      object_ids.pop
                    end
                end
                output << (if (count -= 1) > 0 then ",\n" else "\n" end)
              end
            end
          output << " "*level
          output << ">"
          end
      end
  end

end
