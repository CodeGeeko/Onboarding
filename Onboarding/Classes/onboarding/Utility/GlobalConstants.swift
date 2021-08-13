import Foundation

public class GlobalConstant {
    static var introScenes: [IntroScene] {
        var list: [IntroScene] = []
        list.append(IntroScene(name: "First", mainTitle: "Hey there! Welcome to our App", animationName: "onboarding-car"))
        list.append(IntroScene(name: "Second", mainTitle: "Please bear with us for onborading", animationName: "onboarding-piggy-bank"))
        list.append(IntroScene(name: "Third", mainTitle: "You are all caugth up", animationName: "loading-checkmark"))
        return list
    }
}
