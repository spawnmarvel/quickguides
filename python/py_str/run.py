def string_iteration():
    a_str = "a1string3words"
    print(len(a_str))
    # iteration
    for s in a_str:
        if s == "1":
            print("Number")
    # index and val in string
    for idx, val in enumerate(a_str):
        if val == "1":
            print(str(idx) + " ; " + val )
    # slicing
    rv = a_str[0:4]
    print(rv)


string_iteration()