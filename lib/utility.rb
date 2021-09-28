### utility function to check if a string is an integer
def integer?(str)
  !Integer(str, exception: false).nil?
end
