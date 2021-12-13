input = 'by-TW
start-TW
fw-end
QZ-end
JH-by
ka-start
ka-by
end-JH
QZ-cv
vg-TI
by-fw
QZ-by
JH-ka
JH-vg
vg-fw
TW-cv
QZ-vg
ka-TW
ka-QZ
JH-fw
vg-hu
cv-start
by-cv
ka-cv'.split(/\n/).map{|x|x.split('-')}

hash={}
input.each do |i|
  hash[i[0]] = [] if hash[i[0]].nil?
  hash[i[1]] = [] if hash[i[1]].nil?
  hash[i[0]].push(i[1])
  hash[i[1]].push(i[0])
end

# Part 1
# def is_finished?(path)
#   path.last == 'start' ||
#   (path.last == path.last.downcase &&
#   path.length > 1 && path.count(path.last) > 1)
# end

def more_than_one_small_twice?(path)
  return true if path.last==path.last.downcase && path.count(path.last) > 2
  smallTwices=Set.new
  path.each do |p|
    smallTwices << p if p==p.downcase && path.count(p) > 1
    return true if smallTwices.length > 1
  end
  false
end

def is_finished?(path)
  path.count('end') > 1 || path.last == 'start' || more_than_one_small_twice?(path)
end

paths = Set.new
paths << ['end']

while(!paths.all?{|p| is_finished?(p)}) do
  newPaths=[]
  paths.each do |p|
    next if p == 'end'
    if is_finished?(p)
      newPaths.push(p)
      next
    end
    nextSet = hash[p.last]
    nextSet.each do |n|
      newPaths.push(p + [n])
    end
  end
  paths = newPaths
end

p paths.select{|x|x.last=='start' && x.any?{|x|x==x.downcase}}.length
