xRange=282..314
yRange=-80..-45

possibleSteps = {}
maxSteps=0
for x in 0..xRange.max
  possibleSteps[x]=[]
  for steps in 0..xRange.min
    step_dif= x-steps > 0 ? x-steps : 0
    if xRange.include?((step_dif..x).sum)
      possibleSteps[x] << steps+1
      maxSteps=[maxSteps,steps+1].max
    end
  end
end

maxHeight=0
distinctValues=Set.new
for x in possibleSteps.keys
  for steps in possibleSteps[x]
    for y in yRange.min..maxSteps-(yRange.max.abs)
      if yRange.include?((y-steps+1..y).sum) 
        maxHeight=[maxHeight,(1..y).sum].max
        distinctValues << x.to_s+','+y.to_s
      end
    end
  end
end

p maxHeight
p distinctValues.length
