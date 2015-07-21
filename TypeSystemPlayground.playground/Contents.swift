/*: 
  # Mind-blowing Type System

Swift's type system is a source of frustration and not few developer state that is solves a problem nobody had. In my opinion it's useful mainly for beginners. It helps to find misunderstandings of Cocoa APIs and other people's code early. But I also think that the influence on the number of bad bugs in shipped apps is low. Most of the prevented errors are so obvious that they get caught during debug runs.

But a few days ago I stubbled across a feature of Swift's type system that blew my mind.
*/
import UIKit

/*!
  You sure have seen already this kind of type inference:
*/

func aNumber() -> Int { return 1 }
func aNumber() -> Double { return 2.0 }

let a: Int = aNumber()
let b: Double = aNumber()

/*!
  Or even something link this:
 */

protocol Multipliable: Equatable {
  func *(lhs: Self, rhs: Self) -> Self
}

func multiply<T: Multipliable>(first: T, second: T) -> T {
  return first * second
}

extension Int : Multipliable {}
extension Double : Multipliable {}

let anoterInt: Int = multiply(aNumber(), second: aNumber())
let anoterDouble: Double = multiply(aNumber(), second: aNumber())

/*!
  So far so good. Let's take this to the next level. <span class="lang:swift decode:true  crayon-inline ">UIView</span> has an initializer that takes a <span class="lang:swift decode:true  crayon-inline ">CGRect</span>. This makes the following type inference possible:
 */
var coloredView = UIView(frame: .zeroRect)

coloredView = UIView(frame: CGRectMake(0, 0, 50, 50))

/*!
  This is already kind of cool. But there is more. The type system can handle code like this:
 */
coloredView.backgroundColor = .yellowColor()
coloredView

extension UIColor {
  class func viewBackgroundColor() -> UIColor {
    return self.init(red: 0.5, green: 0.5, blue: 1.0, alpha: 1.0)
  }
}

coloredView.backgroundColor = .viewBackgroundColor()

extension UIColor {
  class func someColors() -> [UIColor] {
    return [.redColor(), .blueColor()]
  }
}

var colors = [UIColor]()
colors.append(.whiteColor())
//colors += .someColors()

//let someColors: [UIColor] = .someColors()


