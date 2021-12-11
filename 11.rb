input = '8448854321
4447645251
6542573645
4725275268
6442514153
4515734868
5513676158
3257376185
2172424467
6775163586'.split(/\n/).map{|x|x.chars.map(&:to_i)}

def handleFlash(y,x,input,flashing)
  for dy in -1..1
    for dx in -1..1
      if (y+dy).between?(0,input.length-1) && (x+dx).between?(0,input[0].length-1)
        next if flashing.include?((y+dy).to_s+(x+dx).to_s)
        input[y+dy][x+dx]+=1
        input[y+dy][x+dx]%=10
        if input[y+dy][x+dx] == 0
          flashing.push((y+dy).to_s+(x+dx).to_s)
          handleFlash(y+dy,x+dx,input,flashing)
        end
      end
    end
  end
end

counter=0
steps=0
flashing=[]
while flashing.length < input.length*input[0].length do
  steps+=1
  flashing=[]
  for y in 0..input.length-1
    for x in 0..input[0].length-1
      input[y][x]+=1
      input[y][x]%=10
      if input[y][x] == 0
        flashing.push(y.to_s+x.to_s)
        handleFlash(y,x,input,flashing)
      end
    end
  end
  counter+=flashing.length
  flashing.each do |f|
    input[f.chars[0].to_i][f.chars[1].to_i] = 0
  end
  p counter if steps==100
end

p steps
