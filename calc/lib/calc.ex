defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """


  def main() do
    IO.gets("> ")
    |> eval()
    |>IO.puts
    main()
  end

  def eval(s) do
    String.to_charlist(s)
    |> trimSpaces()
    |> helper(0,0,0)
  end

  # Evaluates the charList c
  # If Sign is 1 then last character was '-' ,if it is 0, then '+'
  # If Operator is 1, the last character was '*', else if it is -1 then it was '/' . If it is 0,
  # then it was neither '/' nor '*'
  def helper(c,last_num,sign,operator) do
    if(c == []) do 0
  else
    index=0
    c= trimSpaces(c)
    size=Enum.count(c)
    symbol=Enum.at(c,index)
    ans=0

    case symbol do
      # If the symbol is Integer
      n when  n>=48 and n<= 57 -> num_index= findNumberIndex(c,size)
      ans= List.to_integer(Enum.slice(c,0..num_index-1))

      if(sign==1) do
        evalLastOperator(c,last_num,operator,size,num_index,ans*-1)
      else evalLastOperator(c,last_num,operator,size,num_index,ans)
    end

    # If the symbol is '(' sign
    ?( -> num_index= findClosingBracket(c,0,0)
    ans=helper(Enum.slice(c,1..num_index-1),0,0,0)

    if(sign==1) do
      evalLastOperator(c,last_num,operator,size,num_index+1,ans*-1)
    else evalLastOperator(c,last_num,operator,size,num_index+1,ans)
  end

  # If the symbol is '+' sign
  ?+ -> helper(Enum.slice(c,1..size),last_num,0,0)

  # If the symbol is '-' sign
  ?- ->helper(Enum.slice(c,1..size),last_num,1,0)

  # If the symbol is '*' sign
  ?* -> helper(Enum.slice(c,1..size),last_num,0,1)
  # If the symbol is '/' sign
  ?/ -> helper(Enum.slice(c,1..size),last_num,0,-1)
  #If it is endLine(LineFeed) character
  10 -> 0
end
end
end

# Returns the index where the number ends(before any space or operator)
def findNumberIndex(c,size) do
  res=Enum.find_index(c, fn(x) -> x<48 or x>57 end)
  if(res==nil) do size else res end

end

# Return the index of the last closing bracket that matches this starting bracket
def findClosingBracket(c,index,size) do
  symbol= Enum.fetch!(c, index)
  cond do
    symbol==40-> findClosingHelper(c,index,size+1)
    symbol==41 -> findClosingHelper(c,index,size-1)
    true-> findClosingHelper(c,index,size)
  end
end

# return current index if size is 0 otherwise call findClosingBracket function
def findClosingHelper(c,index,size) do
  if(size==0) do
    index
  else
    findClosingBracket(c,index+1,size)
  end
end

# Trims the input charlist(Remove spaces from starting of charList)
def trimSpaces(c) do
  Enum.drop_while(c, fn(x)-> x== 32 end)
end

#  To evaluate the last operator('/' or '*')
def evalLastOperator(c,last_num,operator,size,num_index,ans) do
  cond do
    operator== 1 -> ans*last_num - last_num + helper(Enum.slice(c,num_index..size),ans*last_num,0,0)
    operator== -1 -> div(last_num,ans) - last_num + helper(Enum.slice(c,num_index..size),div(last_num,ans),0,0)
    true ->  ans + helper(Enum.slice(c,num_index..size),ans,0,0)
  end
end

end
