//: Playground - noun: a place where people can play

import Foundation
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nWelcome to Max's Project Euler playground\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

struct ProblemSelection : OptionSet {
    let rawValue: Int
    
    static let none      = ProblemSelection(rawValue: 0)
    static let problem1  = ProblemSelection(rawValue: 1 << 0)
    static let problem2  = ProblemSelection(rawValue: 1 << 1)
    static let problem3  = ProblemSelection(rawValue: 1 << 2)
    static let problem4  = ProblemSelection(rawValue: 1 << 3)
    static let problem5  = ProblemSelection(rawValue: 1 << 4)
    static let problem6  = ProblemSelection(rawValue: 1 << 5)
    static let problem7  = ProblemSelection(rawValue: 1 << 6)
    static let problem8  = ProblemSelection(rawValue: 1 << 7)
    static let problem9  = ProblemSelection(rawValue: 1 << 8)
    static let problem10 = ProblemSelection(rawValue: 1 << 9)
    static let problem11 = ProblemSelection(rawValue: 1 << 10)
    static let problem12 = ProblemSelection(rawValue: 1 << 11)
    static let problem13 = ProblemSelection(rawValue: 1 << 12)
    static let problem14 = ProblemSelection(rawValue: 1 << 13)
    static let problem15 = ProblemSelection(rawValue: 1 << 14)
    static let problem16 = ProblemSelection(rawValue: 1 << 15)
    static let problem17 = ProblemSelection(rawValue: 1 << 16)
    static let problem18 = ProblemSelection(rawValue: 1 << 17)
    static let problem19 = ProblemSelection(rawValue: 1 << 18)
    static let problem20 = ProblemSelection(rawValue: 1 << 19)
    
    static let all: ProblemSelection = [.problem1, .problem2, .problem3, .problem4, .problem5,
                                        .problem6, .problem7, .problem8, .problem9, .problem10,
                                        .problem11, .problem12, .problem13, .problem14, .problem15]
    
    static let problemFives1: ProblemSelection = [.problem1, .problem2, .problem3, .problem4, .problem5]
    
    static let problemFives2: ProblemSelection = [.problem6, .problem7, .problem8, .problem9, .problem10]
    
    static let problemFives3: ProblemSelection = [.problem11, .problem12, .problem13, .problem14, .problem15]
}
// To save a little recomputation time, select the problems you'd like to see with the mask
let problemMask: ProblemSelection = [.problem1, .problem2, .problem3, .problem4, .problem5,
                                     .problem6, .problem7, .problem8, .problem9, .problem10,
                                     .problem11, .problem13, .problem14]


// Prints out formatted outputs.
func printTestCase(_ result: Any) {
    print("Sample case:", result)
}
func printResultCase(_ result: Any) {
    print("Application:", result)
}

func wrapProblem(problem: ProblemSelection, solution: ()->Array<Any>, answerFormatting: (Any)->Any = { (answer) -> Any in return answer }) {
    if problemMask.contains(problem) {
        let start = Date()
        let answer = solution()
        let seconds = Date().timeIntervalSince(start)
        switch answer.count {
        case 1:
            printResultCase(answerFormatting(answer.first!))
        case 2:
            printTestCase(answerFormatting(answer.first!))
            printResultCase(answerFormatting(answer.last!))
        default:
            print("Couldn't understand answer \(answer)")
        }
        print("Solution took \(seconds) seconds");
    }
}

// Utility functions.

// Returns an array of primes numbers up to the limit.
func primes(upTo limit: Int) -> Array<Int> {
    var candidates = Array<Bool>(repeating: true, count: limit/2)
    let offset = 1
    candidates[0] = false

    var primes = [2]

    for index in 1...candidates.count-1 {
        if candidates[index] {
            let value = index * 2 + offset;
            var multiple = index + value
            while multiple < candidates.count {
                candidates[multiple] = false
                multiple += value
            }
            primes.append(index * 2 + offset)
        }
    }

    return primes
}

// Returns an array of prime factors. The array should be in accending order.
// As a side effect of finding the factors this function creates a list of primes up to the value of num.
// This is an area for optimization with caching.
func primeFactorsOf(_ num: Int) -> Array<Int> {
    // Discover primes
    var primes = Array<Int>()
    var currentExamination = 2
    if primes.count > 0 {
        currentExamination = primes.last!+1
    }
    // Check factor
    var factors = Array<Int>()
    var currentVal = num
    
    while (currentExamination <= currentVal && (primes.count == 0 || currentVal >= primes.first!)) {
        var isPrime = true
        for prime in primes {
            if currentExamination % prime == 0 {
                isPrime = false
                break
            }
        }
        if isPrime {
            primes.append(currentExamination)
            while currentVal % currentExamination == 0 {
                factors.append(currentExamination)
                currentVal /= currentExamination
            }
        }
        currentExamination += 1
    }
    return factors
}

// Returns the value of base raised to exponenet
func intPower(_ base: Int, _ exponent: Int) -> Int {
    return Int(pow(Double(base),Double(exponent)))
}

// Problem 1
wrapProblem(problem: .problem1, solution: {
    print("\nProblem 1")
    
    print("If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.")
    print("Find the sum of all the multiples of 3 or 5 below 1000.")
    func sumOfProducts(baseValues: Set<Int>, limit: Int) -> Int {
        var multiples = Set<Int>()
        
        for baseValue in baseValues {
            var multiple = baseValue
            while multiple < limit {
                multiples.insert(multiple)
                multiple += baseValue
            }
        }
        
        var sum = 0
        for product in multiples {
            sum += product
        }
        return sum
    }
    
    return [sumOfProducts(baseValues: Set([3,5]), limit: 10),sumOfProducts(baseValues: Set([3,5]), limit: 1000)]
})

// Problem 2
wrapProblem(problem: .problem2, solution: {
    print("\nProblem 2")
    
    print("Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:")
    print("    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...")
    print("By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.")
    
    func sumNumbersAndReturnEvenUnderLimit(num1: Int, num2: Int, lim: Int) -> Int {
        let next: Int = num1 + num2
        var sum = 0
        if (num2 % 2 == 0) {
            sum += num2
        }
        if (next < lim) {
            sum += sumNumbersAndReturnEvenUnderLimit(num1: num2, num2: next, lim: lim)
        }
        return sum
    }
    
    return [sumNumbersAndReturnEvenUnderLimit(num1: 1, num2: 2, lim: 90), sumNumbersAndReturnEvenUnderLimit(num1: 1, num2: 2, lim: 4000000)]
})

// Problem 3
wrapProblem(problem: .problem3, solution: {
    print("\nProblem 3")
    
    print("The prime factors of 13195 are 5, 7, 13 and 29.")
    print("What is the largest prime factor of the number 600851475143?")
    
    func largestPrimeFactorOf(_ num: Int) -> Int {
        var primeFactors = primeFactorsOf(num)
        primeFactors.sort(by:>)
        return primeFactors.first!
    }
    
    return [largestPrimeFactorOf(13195), largestPrimeFactorOf(600851475143)]
})

// Problem 4
wrapProblem(problem: .problem4, solution: {
    print("\nProblem 4")
    
    print("A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.")
    print("Find the largest palindrome made from the product of two 3-digit numbers.")
    
    func reverseDigits(_ num: Int, base: Int) -> Int {
        var reversed = 0
        var placeholder = num
        
        while placeholder >= 1 {
            reversed = (reversed * base) + (placeholder % base)
            placeholder /= base
        }
        return reversed
    }
    
    func isPalindrome(_ num: Int, base: Int) -> Bool {
        if num < base {
            return true
        }
        
        if num % base == 0 {
            return false
        }
        
        if num == reverseDigits(num, base: base) {
            return true
        }
        return false
    }
    
    func largestPalindromicProduct(numDigits: Int, base: Int=10) -> Int {
        var maxPalindrome = 0;
        let bottomLimit = intPower(base, numDigits-1)-1
        let upperLimit = intPower(base, numDigits)-1
        
        var a = upperLimit
        while (a > bottomLimit) {
            var b = upperLimit
            while (b >= a) {
                let product = a*b
                if (product > maxPalindrome && isPalindrome(product, base: base)) {
                    maxPalindrome = product
                }
                b -= 1
            }
            a -= 1
        }
        
        return maxPalindrome
    }
    
    return [largestPalindromicProduct(numDigits: 2), largestPalindromicProduct(numDigits: 3)]
})

// Problem 5
wrapProblem(problem: .problem5, solution: {
    print("\nProblem 5")
    
    print("2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.")
    print("What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?")
    func smallestNumberDivisibleByValuesUpTo(_ limit: Int) -> Int {
        var primeFactors = Dictionary<Int, Int>()
        // Not sure if this stride should be inclusive of the limit.
        // The test case given would be agnostic towards this.
        for value in stride(from: 2, through: limit, by: 1) {
            var primeFactorCount = Dictionary<Int, Int>()
            for primeFactor in primeFactorsOf(value) {
                // Can this check be shrunk with swift syntax magic?
                if primeFactorCount[primeFactor] == nil {
                    primeFactorCount[primeFactor] = 1
                }
                else {
                    primeFactorCount[primeFactor] = primeFactorCount[primeFactor]! + 1
                }
            }
            for key in primeFactorCount.keys {
                // Same potential optimization as above.
                if primeFactors[key] == nil {
                    primeFactors[key] = primeFactorCount[key]
                }
                else {
                    primeFactors[key] = max(primeFactors[key]!, primeFactorCount[key]!)
                }
            }
        }
        
        var product = 1
        for prime in primeFactors.keys {
            product *= intPower(prime, primeFactors[prime]!)
        }
        return product
    }
    
    return [smallestNumberDivisibleByValuesUpTo(10), smallestNumberDivisibleByValuesUpTo(20)]
})

// Problem 6
wrapProblem(problem: .problem6, solution: {
    print("\nProblem 6")
    print("The sum of the squares of the first ten natural numbers is, 1^2 + 2^2 + ... + 10^2 = 385")
    print("The square of the sum of the first ten natural numbers is, (1 + 2 + ... + 10)^2 = 55^2 = 3025")
    print("Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.")
    print("Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.")
    
    func sumSquares(_ values: Array<Int>) -> Int {
        return values.reduce(0, { $0 + $1*$1 });
    }
    
    func squareSum(_ values: Array<Int>) -> Int {
        let sum = values.reduce(0, +)
        return sum * sum
    }
    
    func differenceOfSquaresUpTo(_ cap: Int) -> Int {
        let values = Array<Int>(1...cap)
        return squareSum(values) - sumSquares(values)
    }
    
    return [differenceOfSquaresUpTo(10),
            differenceOfSquaresUpTo(100)]
})

// Problem 7
wrapProblem(problem: .problem7, solution: {
    print("\nProblem 7")
    print("By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.")
    print("What is the 10 001st prime number?")
    
    func nthPrime(_ n: Int) -> Int {
        var primes = [Int]()
        var i = 2
        while primes.count < n {
            var isPrime = true
            for p in primes {
                if i % p == 0 {
                    isPrime = false
                    break
                }
            }
            if isPrime {
                primes.append(i)
            }
            i += 1
        }
        
        return primes.last!
    }
    
    return [
        nthPrime(6), // 13
        nthPrime(10001) // 104743
    ]
})

// Problem 8
wrapProblem(problem: .problem8, solution: {
    print("\nProblem 8")
    print("Number: 73167176531330624919225119674426574742355349194934...");
    print("The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.")
    print("Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?")
    
    // Can't store the 1000 digit number as an int.
    let largeDigitNumber = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
    
    func largestProductOfContinuousDigits(_ digitCount: Int , _ n: String) -> Int {
        var maxProduct = 0
        var startIndex = 0
        
        while startIndex + digitCount <= n.characters.count {
            let start = n.index(n.startIndex, offsetBy: startIndex)
            let stop  = n.index(n.startIndex, offsetBy: startIndex + digitCount)
            let slice = n.substring(with: Range(start..<stop))
            
            var consecutiveDigits = Int(slice)!
            var product = 1
            while consecutiveDigits >= 1 {
                product *= consecutiveDigits % 10
                consecutiveDigits /= 10
            }
            maxProduct = max(maxProduct, product)
            
            startIndex += 1
        }
        
        return maxProduct
    }
    
    return [
        largestProductOfContinuousDigits(4, largeDigitNumber),
        largestProductOfContinuousDigits(13, largeDigitNumber)
    ]
})

// Problem 9
wrapProblem(problem: .problem9, solution: {
    print("\nProblem 9")
    print("A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2")
    print("For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.")
    print("There exists exactly one Pythagorean triplet for which a + b + c = 1000.")
    print("Find the product abc.")
    
    func isPythagoreanTriplet(_ nums: Array<Int>) -> Bool {
        if nums.count != 3 {
            return false
        }
        return nums[0]*nums[0] + nums[1]*nums[1] == nums[2]*nums[2]
    }
    
    func findPythagorianTripletsThatSumsTo(_ n: Int) -> Array<Array<Int>> {
        var triplets = Array<Array<Int>>()
        for a in Int(sqrt(Double(n)))...n/3 {
            for b in max((n/2-a), a)...n/2 {
                let c = n - a - b
                let triplet = [a,b,c]
                if isPythagoreanTriplet(triplet) {
                    triplets.append(triplet)
                    break
                }
            }
            if triplets.count > 0 {
                break
            }
        }
        return triplets
    }
    
    return [findPythagorianTripletsThatSumsTo(12).first!.reduce(1, *),
            findPythagorianTripletsThatSumsTo(1000).first!.reduce(1, *)]
})

// Problem 10
wrapProblem(problem: .problem10, solution: {
    print("\nProblem 10")
    print("The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.")
    print("Find the sum of all the primes below two million.")

    func sumPrimesBelow(_ limit: Int) -> Int {
        return primes(upTo: limit).reduce(0, +)
    }

    return [
        sumPrimesBelow(10), // 17
        sumPrimesBelow(2000000) // 142913828922
    ]
})

// Problem 11
wrapProblem(problem: .problem11, solution: {
    print("\nProblem 11")
    print("In the 20×20 grid below, four numbers along a diagonal line have been marked in red.");
    let gridOfNumbers = "08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08\n49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00\n81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65\n52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91\n22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80\n24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50\n32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70\n67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21\n24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72\n21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95\n78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92\n16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57\n86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58\n19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40\n04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66\n88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69\n04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36\n20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16\n20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54\n01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48"
    print(gridOfNumbers)
    print("The product of these numbers is 26 × 63 × 78 × 14 = 1788696.")
    print("What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?")

    func parseGrid(_ gridAsString: String, sequenceLength: Int=4) -> Int {
        let rows = gridAsString.components(separatedBy: "\n")
        var grid = [[Int]]()
        for stringRow in rows {
            let components = stringRow.components(separatedBy: " ")
            var row = [Int]()
            for c in components {
                row.append(Int(c)!)
            }
            grid.append(row)
        }
        
        var maxProduct = 0
        var multiple: Int
        
        for r in 0...grid.count-1 {
            for c in 0...grid[r].count-1 {
                if c <= grid[r].count - sequenceLength {
                    // check left to right
                    multiple = 1
                    for i in 0...sequenceLength-1 {
                        multiple *= grid[r][c+i]
                    }
                    if (multiple > maxProduct) {
                        maxProduct = multiple
                    }
                }
                if r <= grid.count-1 - sequenceLength {
                    // check top to bottom
                    multiple = 1
                    for i in 0...sequenceLength-1 {
                        multiple *= grid[r+i][c]
                    }
                    if (multiple > maxProduct) {
                        maxProduct = multiple
                    }
                    
                    if c <= grid[r].count - sequenceLength {
                        // check diagonal top left to bottom right
                        multiple = 1
                        for i in 0...sequenceLength-1 {
                            multiple *= grid[r+i][c+i]
                        }
                        if (multiple > maxProduct) {
                            maxProduct = multiple
                        }
                    }
                    if c >= sequenceLength-1 {
                        // check diagonal top right to bottom left
                        multiple = 1
                        for i in 0...sequenceLength-1 {
                            multiple *= grid[r+i][c-i]
                        }
                        if (multiple > maxProduct) {
                            maxProduct = multiple
                        }
                    }
                }
            }
        }
        return maxProduct
    }
    return [parseGrid(gridOfNumbers)]
})

// Problem 12
wrapProblem(problem: .problem12, solution: {
    print("\nProblem 12")
    print("The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:")
    print("   1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...")
    print("Let us list the factors of the first seven triangle numbers:")
    print("   1: 1")
    print("   3: 1, 3")
    print("   6: 1, 2, 3, 6")
    print("  10: 1, 2, 5, 10")
    print("  15: 1, 3, 5, 15")
    print("  21: 1, 3, 7, 21")
    print("  28: 1, 2, 4, 7, 14, 28")
    print("We can see that 28 is the first triangle number to have over five divisors.")
    print("What is the value of the first triangle number to have over five hundred divisors?")

    func uniqueDivisorsOfNumber(_ num: Int) -> Set<Int> {
        var divisors = Set<Int>()
        
        var divisor = 1
        while divisor <= num {
            if num % divisor == 0 {
                divisors.insert(divisor)
            }
            divisor += 1
        }
        
        return divisors
    }

    func firstTriangleNumber(withDivisorCount count: Int) -> Int {
        var triangleNumber = 0
        var n = 0
        
        var currentCount = 0
        while currentCount < count {
            n += 1
            triangleNumber += n
            let divisors = uniqueDivisorsOfNumber(triangleNumber)
            currentCount = divisors.count
            print("triangle number \(n) is \(triangleNumber) which has \(currentCount) divisors: \(divisors.sorted()), prime factors: \(primeFactorsOf(triangleNumber))")
        }
        return triangleNumber
    }

    return [firstTriangleNumber(withDivisorCount: 5),
            firstTriangleNumber(withDivisorCount: 500)]
})

// Problem 13
wrapProblem(problem: .problem13, solution: {
    print("\nProblem 13")
    print("Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.")
    let fiftyDigitNumbers = "37107287533902102798797998220837590246510135740250\n46376937677490009712648124896970078050417018260538\n74324986199524741059474233309513058123726617309629\n91942213363574161572522430563301811072406154908250\n23067588207539346171171980310421047513778063246676\n89261670696623633820136378418383684178734361726757\n28112879812849979408065481931592621691275889832738\n44274228917432520321923589422876796487670272189318\n47451445736001306439091167216856844588711603153276\n70386486105843025439939619828917593665686757934951\n62176457141856560629502157223196586755079324193331\n64906352462741904929101432445813822663347944758178\n92575867718337217661963751590579239728245598838407\n58203565325359399008402633568948830189458628227828\n80181199384826282014278194139940567587151170094390\n35398664372827112653829987240784473053190104293586\n86515506006295864861532075273371959191420517255829\n71693888707715466499115593487603532921714970056938\n54370070576826684624621495650076471787294438377604\n53282654108756828443191190634694037855217779295145\n36123272525000296071075082563815656710885258350721\n45876576172410976447339110607218265236877223636045\n17423706905851860660448207621209813287860733969412\n81142660418086830619328460811191061556940512689692\n51934325451728388641918047049293215058642563049483\n62467221648435076201727918039944693004732956340691\n15732444386908125794514089057706229429197107928209\n55037687525678773091862540744969844508330393682126\n18336384825330154686196124348767681297534375946515\n80386287592878490201521685554828717201219257766954\n78182833757993103614740356856449095527097864797581\n16726320100436897842553539920931837441497806860984\n48403098129077791799088218795327364475675590848030\n87086987551392711854517078544161852424320693150332\n59959406895756536782107074926966537676326235447210\n69793950679652694742597709739166693763042633987085\n41052684708299085211399427365734116182760315001271\n65378607361501080857009149939512557028198746004375\n35829035317434717326932123578154982629742552737307\n94953759765105305946966067683156574377167401875275\n88902802571733229619176668713819931811048770190271\n25267680276078003013678680992525463401061632866526\n36270218540497705585629946580636237993140746255962\n24074486908231174977792365466257246923322810917141\n91430288197103288597806669760892938638285025333403\n34413065578016127815921815005561868836468420090470\n23053081172816430487623791969842487255036638784583\n11487696932154902810424020138335124462181441773470\n63783299490636259666498587618221225225512486764533\n67720186971698544312419572409913959008952310058822\n95548255300263520781532296796249481641953868218774\n76085327132285723110424803456124867697064507995236\n37774242535411291684276865538926205024910326572967\n23701913275725675285653248258265463092207058596522\n29798860272258331913126375147341994889534765745501\n18495701454879288984856827726077713721403798879715\n38298203783031473527721580348144513491373226651381\n34829543829199918180278916522431027392251122869539\n40957953066405232632538044100059654939159879593635\n29746152185502371307642255121183693803580388584903\n41698116222072977186158236678424689157993532961922\n62467957194401269043877107275048102390895523597457\n23189706772547915061505504953922979530901129967519\n86188088225875314529584099251203829009407770775672\n11306739708304724483816533873502340845647058077308\n82959174767140363198008187129011875491310547126581\n97623331044818386269515456334926366572897563400500\n42846280183517070527831839425882145521227251250327\n55121603546981200581762165212827652751691296897789\n32238195734329339946437501907836945765883352399886\n75506164965184775180738168837861091527357929701337\n62177842752192623401942399639168044983993173312731\n32924185707147349566916674687634660915035914677504\n99518671430235219628894890102423325116913619626622\n73267460800591547471830798392868535206946944540724\n76841822524674417161514036427982273348055556214818\n97142617910342598647204516893989422179826088076852\n87783646182799346313767754307809363333018982642090\n10848802521674670883215120185883543223812876952786\n71329612474782464538636993009049310363619763878039\n62184073572399794223406235393808339651327408011116\n66627891981488087797941876876144230030984490851411\n60661826293682836764744779239180335110989069790714\n85786944089552990653640447425576083659976645795096\n66024396409905389607120198219976047599490197230297\n64913982680032973156037120041377903785566085089252\n16730939319872750275468906903707539413042652315011\n94809377245048795150954100921645863754710598436791\n78639167021187492431995700641917969777599028300699\n15368713711936614952811305876380278410754449733078\n40789923115535562561142322423255033685442488917353\n44889911501440648020369068063960672322193204149535\n41503128880339536053299340368006977710650566631954\n81234880673210146739058568557934581403627822703280\n82616570773948327592232845941706525094512325230608\n22918802058777319719839450180888072429661980811197\n77158542502016545090413245809786882778948721859617\n72107838435069186155435662884062257473692284509516\n20849603980134001723930671666823555245252804609722\n53503534226472524250874054075591789781264330331690"
    
    func convertStringToIntArray(_ s: String) -> [Int] {
        var numbers = [Int]()
        for i in 0...s.characters.count-1 {
            let start = s.index(s.startIndex, offsetBy: i)
            let stop  = s.index(s.startIndex, offsetBy: i + 1)
            let slice = s.substring(with: Range(start..<stop))
            numbers.append(Int(slice)!)
        }
        return numbers.reversed()
    }

    func parseSringIntoArray(_ numbers: String, _ separator: String) -> [[Int]] {
        let numberStrings = numbers.components(separatedBy: separator)
        return numberStrings.map(convertStringToIntArray)
    }
    
    func first(nDigits count: Int, ofString s: String, separator: String = "\n") -> [Any] {
        var numbers = parseSringIntoArray(s, separator)
        var digits = [Int]()
        var remainder = [Int]()
        
        func indexWithinLargestSubArray(index: Int, intArray: [[Int]]) -> Bool {
            for subArray in intArray {
                if index < subArray.count {
                    return true
                }
            }
            return false
        }
        
        var digitIndex = 0
        while indexWithinLargestSubArray(index: digitIndex, intArray: numbers) || remainder.count > 0  {
            var sum = 0
            for i in 0...numbers.count-1 {
                if numbers[i].count > digitIndex {
                    sum += numbers[i][digitIndex]
                }
            }
            if remainder.count > 0 {
                sum += remainder.first!
                remainder.removeFirst()
            }
            digits.append(sum%10)
            
            var remainderDigit = 0
            while sum >= 1 {
                sum /= 10
                if remainder.count > remainderDigit {
                    remainder[remainderDigit] += sum%10
                }
                else {
                    remainder.append(sum%10)
                }
                remainderDigit += 1
            }
            digitIndex += 1
        }
        digits.reverse()
        while digits.count > 0 && digits.first! == 0 {
            digits.removeFirst()
        }
        
        return [count, digits.dropLast((digits.count > count) ? digits.count - count : 0)]
    }
    
    return [first(nDigits: 10, ofString: fiftyDigitNumbers)]
    }, answerFormatting: { (answer) -> Any in
        let countAndDigits = answer as! [Any]
        return "The first \(countAndDigits.first!) digits of the sum of input numbers are \(countAndDigits.last!)"
})

// Problem 14
wrapProblem(problem: .problem14, solution: {
    print("\nProblem 14")
    print("The following iterative sequence is defined for the set of positive integers:")
    print("   n → n/2 (n is even)")
    print("   n → 3n + 1 (n is odd)")
    print("Using the rule above and starting with 13, we generate the following sequence:")
    print("   13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1")
    print("It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.")
    print("Which starting number, under one million, produces the longest chain?")
    print("Once the chain starts the terms are allowed to go above one million.")
    
    // Odd: next = 3*n + 1
    // Even: next = n/2
    // Reverse order
    // Odd: prev = 2 * n
    // Even: prev = 2 * n || (n-1)/3
    
    func nextStepInSequence(_ n: Int) -> Int {
        if n%2 == 0 {
            return n/2
        }
        return 3*n + 1
    }
    var cachedCounts = [Int: Int]()
    
    func lengthOfIterativeSequence(forNumber n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if cachedCounts[n] != nil {
            return cachedCounts[n]!
        }
        let length = 1 + lengthOfIterativeSequence(forNumber: nextStepInSequence(n))
        cachedCounts[n] = length
        return length
    }
    
    func longestIterativeSequence(upTo cap: Int) -> [Int] {
        
        var largestSequence = 1
        var largestSequenceTrigger = 1
        for n in 2...cap-1 {
            let seqLen = lengthOfIterativeSequence(forNumber: n)
            if seqLen > largestSequence {
                largestSequence = seqLen
                largestSequenceTrigger = n
            }
        }
        return [largestSequenceTrigger, largestSequence]
    }
    
    return [[13, lengthOfIterativeSequence(forNumber: 13)],
            longestIterativeSequence(upTo:1000000)] // 837799 : 525
    }, answerFormatting: { (answer) -> Any in
        let a = answer as! [Int]
        return "Starting at \(a.first!) the sequence length will be \(a.last!)"
})

// Problem 15
wrapProblem(problem: .problem15, solution: {
    print("\nProblem 15")
    print("Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.")
    print(" 1 →, →, ↓, ↓")
    print(" 2 →, ↓, →, ↓")
    print(" 3 →, ↓, ↓, →")
    print(" 4 ↓, →, →, ↓")
    print(" 5 ↓, →, ↓, →")
    print(" 6 ↓, ↓, →, →")
    print("How many such routes are there through a 20×20 grid?")
    
    // For a NxM grid there are N+M required moves. N → and M ↓.
    // Starting with all of one arranged on the left we can count each available pattern by moving to the right
    
    func countTotalUniquePathsForASquareGrid(n: Int) -> Int {
        // n+1 -> 0 sum
        var count = 0
        for i in 1...n+1 {
            count += i
        }
        return count
    }

    return [countTotalUniquePathsForASquareGrid(n: 2),
            countTotalUniquePathsForASquareGrid(n: 20)]
})


// Problem 16
wrapProblem(problem: .problem16, solution: {
    print("\nProblem 16")
    print("2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.")
    print("What is the sum of the digits of the number 2^1000?")
    
    return []
})

 // Problem 17
 wrapProblem(problem: .problem17, solution: {
 print("\nProblem 17")
    print("If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.")
    print("If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?")
    print("NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of \"and\" when writing out numbers is in compliance with British usage.")
 
 return []
 })

 // Problem 18
 wrapProblem(problem: .problem18, solution: {
 print("\nProblem 18")
    print("By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.")
    print("     3")
    print("    7 4")
    print("   2 4 6")
    print("  8 5 9 3")
    print("That is, 3 + 7 + 4 + 9 = 23.")
    print("That is, 3 + 7 + 4 + 9 = 23.")
    print("Find the maximum total from top to bottom of the triangle below:")
    print("                            75")
    print("                          95  64")
    print("                        17  47  82")
    print("                      18  35  87  10")
    print("                    20  04  82  47  65")
    print("                  19  01  23  75  03  34")
    print("                88  02  77  73  07  63  67")
    print("              99  65  04  28  06  16  70  92")
    print("            41  41  26  56  83  40  80  70  33")
    print("          41  48  72  33  47  32  37  16  94  29")
    print("        53  71  44  65  25  43  91  52  97  51  14")
    print("      70  11  33  28  77  73  17  78  39  68  17  57")
    print("    91  71  52  38  17  14  91  43  58  50  27  29  48")
    print("  63  66  04  68  89  53  67  30  73  16  69  87  40  31")
    print("04  62  98  27  23  09  70  98  73  93  38  53  60  40  23")
    
    class Node {
        let val: Int
        var _left: Node?
        var left: Node? {
            set {
                _left?.parentRight = nil
                _left = newValue
                _left?.parentRight = self
            }
            get {
                return _left
            }
        }
        var _right: Node?
        var right: Node? {
            set {
                _right?.parentLeft = nil
                _right = newValue
                _right?.parentLeft = self
            }
            get {
                return _right
            }
        }
        weak var parentRight: Node?
        weak var parentLeft: Node?
        
        init(_ val: Int, _ left: Node?, _ right: Node?) {
            self.val = val
            self.left = left
            self.right = right
        }
        
        convenience init(_ val: Int) {
            self.init(val, nil, nil)
        }
        
        static func treeWithRootNode(from stringRepresentation: String) -> Node? {
            let rows = stringRepresentation.components(separatedBy: "\n")
            var nodes = [[Int]]()
            for i in 0...rows.count-1 {
                nodes.append([Int]())
                nodes[i] = rows[i].components(separatedBy: " ").map({ (s) -> Int in
                    return Int(s)!
                })
            }
            
            for row in nodes.reversed() {
                for i in 0...row.count-1 {
                    let node = Node(row[i])
                }
            }
        }
    }
 
 return []
 })

 // Problem 19
 wrapProblem(problem: .problem19, solution: {
    print("\nProblem 19")
    print("You are given the following information, but you may prefer to do some research for yourself.")
    print("* 1 Jan 1900 was a Monday.")
    print("* Thirty days has September,")
    print("  April, June and November.")
    print("  All the rest have thirty-one,")
    print("  Saving February alone,")
    print("  Which has twenty-eight, rain or shine.")
    print("  And on leap years, twenty-nine.")
    print("* A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.")
    print("How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?")
    
    
    
    
    
 
 return []
 })

 // Problem 20
 wrapProblem(problem: .problem20, solution: {
 print("\nProblem 20")
    print("n! means n × (n − 1) × ... × 3 × 2 × 1")
    print("For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,")
    print("and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.")
    print("Find the sum of the digits in the number 100!")
 
 return []
 })

/*
// Problem <# n #>
wrapProblem(problem: .problem<#n#>, solution: {
    print("\nProblem <#n#>")
    print("<#description#>")

    return []
})
 */
