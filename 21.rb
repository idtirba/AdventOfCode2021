players=[2,5]
scores=[0,0]
positions=*(1..10)
dice=*(1..100)
rolls=0
player=1

while !scores.any? {|s|s>999}
  val=dice[(rolls)%100]+dice[(rolls+1)%100]+dice[(rolls+2)%100]
  rolls+=3
  if player%2==1
    players[0]=positions[(players[0]+val-1)%10]
    scores[0]+=players[0]
  else
    players[1]=positions[(players[1]+val-1)%10]
    scores[1]+=players[1]
  end
  if scores.any? {|s|s>999}
    p scores.min * rolls
    break
  end
  player+=1
end

permutations={}
for x in 1..3
  for y in 1..3
    for z in 1..3
      permutations[x+y+z]=permutations[x+y+z] ? permutations[x+y+z]+1 : 1
    end
  end
end

universes=Hash.new(0)
universes[[[2,0],[5,0]]]=1
wins=[0,0]
curPlayer=0

while universes.any?
  newUniverses=Hash.new(0)
  universes.each do |players, instances|
    p = curPlayer%2<1 ? players[0] : players[1]
    permutations.each do |val, n|
      position=positions[(p[0]+val-1)%10]
      score=p[1]+position
      if score>20
        wins[curPlayer%2]+=n*instances
      else
        if curPlayer%2<1
          newUniverses[[[position,score],players[1]]]+=n*instances
        else
          newUniverses[[players[0],[position,score]]]+=n*instances
        end
      end
    end
    universes.delete(players)
  end
  universes.merge!(newUniverses)
  curPlayer+=1
end

p wins.max
