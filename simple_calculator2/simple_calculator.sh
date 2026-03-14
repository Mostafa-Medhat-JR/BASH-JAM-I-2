#!/bin/bash

# Function to perform the calculation
calculate() {
    local num1=$1
    local num2=$2
    local operator=$3

    case $operator in
        "+")
            result=$(echo "$num1 + $num2" | bc -l)
            ;;
        "-")
            result=$(echo "$num1 - $num2" | bc -l)
            ;;
        "*")
            result=$(echo "$num1 * $num2" | bc -l)
            ;;
        "/")
            if [ $(echo "$num2 == 0" | bc) -eq 1 ]; then
                echo "Error: Division by zero is not allowed!"
                return 1
            fi
            result=$(echo "$num1 / $num2" | bc -l)
            ;;
        *)
            echo "Error: Invalid operation. Please use +, -, *, or /"
            return 1
            ;;
    esac

    # Remove trailing zeros for cleaner output
    echo "$result" | sed 's/\.0*$//'
    return 0
}

# Function to check if input is a number
is_number() {
    [[ $1 =~ ^-?[0-9]+\.?[0-9]*$ ]] || [[ $1 =~ ^-?\.[0-9]+$ ]]
}

# Main program
echo "=================================="
echo "      Simple Bash Calculator      "
echo "=================================="

while true; do
    # Get first number
    while true; do
        read -p "Enter first number: " num1
        if is_number "$num1"; then
            break
        else
            echo "Error: Please enter a valid number (e.g., 5, -3, 2.5)"
        fi
    done

    # Get operator
    while true; do
        read -p "Enter operator (+, -, *, /): " operator
        if [[ "$operator" == "+" || "$operator" == "-" || "$operator" == "*" || "$operator" == "/" ]]; then
            break
        else
            echo "Error: Please enter a valid operator (+, -, *, /)"
        fi
    done

    # Get second number
    while true; do
        read -p "Enter second number: " num2
        if is_number "$num2"; then
            break
        else
            echo "Error: Please enter a valid number (e.g., 5, -3, 2.5)"
        fi
    done

    # Perform calculation
    echo -n "Result: $num1 $operator $num2 = "
    result=$(calculate "$num1" "$num2" "$operator")

    if [ $? -eq 0 ]; then
        echo "$result"
    fi

    # Ask if user wants to perform another operation
    echo ""
    while true; do
        read -p "Do you want to perform another operation? (yes/no): " answer
        case $answer in
            [Yy][Ee][Ss]|[Yy])
                echo "--------------------------"
                break
                ;;
            [Nn][Oo]|[Nn])
                echo "=================================="
                echo "Thank you for using the calculator!"
                echo "=================================="
                exit 0
                ;;
            *)
                echo "Please answer 'yes' or 'no'"
                ;;
        esac
    done
done
