str = 'VHCKBFOVCHHKOHBPNCKO'
input = 'SO -> F
OP -> V
NF -> F
BO -> V
BH -> S
VB -> B
SV -> B
BK -> S
KC -> N
SP -> O
CP -> O
VN -> O
HO -> S
PC -> B
CS -> O
PO -> K
KF -> B
BP -> K
VO -> O
HB -> N
PH -> O
FF -> O
FB -> K
CC -> H
FK -> F
HV -> P
CO -> S
OC -> N
KV -> V
SS -> O
FC -> O
NP -> B
OH -> B
OF -> K
KB -> K
BN -> C
OK -> C
NC -> O
NO -> O
FS -> C
VP -> K
KP -> S
VS -> B
VV -> N
NN -> P
KH -> P
OB -> H
HP -> H
KK -> H
FH -> F
KS -> V
BS -> V
SN -> H
CB -> B
HN -> K
SB -> O
OS -> K
BC -> H
OV -> N
PN -> B
VH -> N
SK -> C
PV -> K
VC -> N
PF -> S
NB -> B
PP -> S
NS -> F
PB -> B
CV -> C
HK -> P
PK -> S
NH -> B
SH -> V
KO -> H
NV -> B
HH -> V
FO -> O
CK -> O
VK -> F
HF -> O
BF -> C
BV -> P
KN -> K
VF -> C
FN -> V
ON -> C
SF -> F
SC -> C
OO -> S
FP -> K
PS -> C
NK -> O
BB -> V
HC -> H
FV -> V
CH -> N
HS -> V
CF -> F
CN -> S'.split(/\n/).map{|x|x.split(/ -> /)}

dict = {}
input.each do |l|
  dict[l[0]] = l[1]
end

pairs = Hash.new(0)
for x in 0..str.length-2
  pairs[str[x..x+1]]+=1
end

40.times do
  newPairs = pairs.clone
  pairs.each do |k,v|
    newPairs[k]-=v
    newPairs[k[0]+dict[k]]+=v
    newPairs[dict[k]+k[1]]+=v
  end
  pairs = newPairs
end

counts = Hash.new(0)
pairs.each do |k,v|
  counts[k[0]]+=v
end

# add closing char
counts[str[-1]]+=1
p counts.values.max - counts.values.min
