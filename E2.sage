load("__common__.sage")

def generator():
    # create a 3x5,4x4,5x3 matrix
    rows = randrange(3,6)
    columns = 8-rows

    #start with nice RREF
    max_number_of_pivots = min(rows,columns)-1
    number_of_pivots = randrange(2,max_number_of_pivots+1)
    A = random_matrix(ZZ,rows,columns,algorithm='echelonizable',rank=number_of_pivots,upper_bound=13)

    #Create an almost-RREF matrix by doing one row op to an RREF

    rowop = choice(["elementary","diagonal","permutation"])
    s=ZZ(choice([randrange(2,8)])*int(choice([-1,1])))
    if rowop=="elementary":
        r=randrange(0,number_of_pivots)
        rr=choice(list(range(0,r))+list(range(r+1,number_of_pivots)))
        E=elementary_matrix(rows, row1=r, row2=rr, scale=s)
    if rowop=="diagonal":
        E=elementary_matrix(rows, row1=randrange(0,number_of_pivots), scale=s)
    if rowop=="permutation":
        r=randrange(0,number_of_pivots)
        rr=choice(list(range(0,r))+list(range(r+1,number_of_pivots)))
        E=elementary_matrix(rows, row1=r, row2=rr)

    B = E*random_matrix(ZZ,rows,columns,algorithm='echelonizable',rank=number_of_pivots,upper_bound=13).rref()

    return {
      "A": A,
      "rref": A.rref(),
      "B": B,
      "rowop": rowop,
      "Brref": (B==B.rref())
    }
