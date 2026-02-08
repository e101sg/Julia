# --- 1. The Logic Layer (Multiple Dispatch) ---

# Using Real handles Ints, Floats, etc.
process(x::Real, y::Real) = begin
    println("Logic: Adding two numbers.")
    return x + y
end

# Using AbstractString handles Strings AND SubStrings
process(x::AbstractString, y::AbstractString) = begin
    println("Logic: Concatenating two strings.")
    return x * " " * y
end

process(x::Real, y::AbstractString) = "Error: Cannot add numeric $x to string '$y'."
process(x::AbstractString, y::Real) = process(y, x)

# --- 2. The Input Layer (Fixed Type Signature) ---

# We changed (s::String) to (s::AbstractString)
function parse_input(s::AbstractString)
    # Try Integer
    val_int = tryparse(Int, s)
    !isnothing(val_int) && return val_int
    
    # Try Float
    val_float = tryparse(Float64, s)
    !isnothing(val_float) && return val_float
    
    # Otherwise, return the string as-is
    return s
end

# --- 3. The User Interface ---

function main()
    println("=== Fixed Dispatch Calculator ===")
    
    while true
        print("\nEnter Input 1 (or 'exit'): ")
        raw1 = strip(readline())
        raw1 == "exit" && break
        
        print("Enter Input 2: ")
        raw2 = strip(readline())
        
        # Now parse_input accepts the SubString from strip()
        val1 = parse_input(raw1)
        val2 = parse_input(raw2)
        
        result = process(val1, val2)
        println("Result ($(typeof(val1)) + $(typeof(val2))): $result")
    end
end

main()