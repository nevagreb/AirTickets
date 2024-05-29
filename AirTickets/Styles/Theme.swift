import SwiftUI
import UIKit


enum Colors {
	static var black: Color {
    	return color(
        	dark: UIColor(red: 0.0470588244497776, green: 0.0470588244497776, blue: 0.0470588244497776, alpha: 1),
        	light: UIColor(red: 0.0470588244497776, green: 0.0470588244497776, blue: 0.0470588244497776, alpha: 1)
    	)
	}

	static var grey1: Color {
    	return color(
        	dark: UIColor(red: 0.11372549086809158, green: 0.11764705926179886, blue: 0.125490203499794, alpha: 1),
        	light: UIColor(red: 0.11372549086809158, green: 0.11764705926179886, blue: 0.125490203499794, alpha: 1)
    	)
	}

	static var grey2: Color {
    	return color(
        	dark: UIColor(red: 0.1411764770746231, green: 0.14509804546833038, blue: 0.16078431904315948, alpha: 1),
        	light: UIColor(red: 0.1411764770746231, green: 0.14509804546833038, blue: 0.16078431904315948, alpha: 1)
    	)
	}

	static var grey3: Color {
    	return color(
        	dark: UIColor(red: 0.18431372940540314, green: 0.1882352977991104, blue: 0.2078431397676468, alpha: 1),
        	light: UIColor(red: 0.18431372940540314, green: 0.1882352977991104, blue: 0.2078431397676468, alpha: 1)
    	)
	}

	static var grey4: Color {
    	return color(
        	dark: UIColor(red: 0.24313725531101227, green: 0.24705882370471954, blue: 0.26274511218070984, alpha: 1),
        	light: UIColor(red: 0.24313725531101227, green: 0.24705882370471954, blue: 0.26274511218070984, alpha: 1)
    	)
	}

	static var grey5: Color {
    	return color(
        	dark: UIColor(red: 0.3701660931110382, green: 0.3739820718765259, blue: 0.3816145658493042, alpha: 1),
        	light: UIColor(red: 0.3701660931110382, green: 0.3739820718765259, blue: 0.3816145658493042, alpha: 1)
    	)
	}

	static var grey6: Color {
    	return color(
        	dark: UIColor(red: 0.6233333349227905, green: 0.6233333349227905, blue: 0.6233333349227905, alpha: 1),
        	light: UIColor(red: 0.6233333349227905, green: 0.6233333349227905, blue: 0.6233333349227905, alpha: 1)
    	)
	}

	static var grey7: Color {
    	return color(
        	dark: UIColor(red: 0.8582811951637268, green: 0.8582811951637268, blue: 0.8582811951637268, alpha: 1),
        	light: UIColor(red: 0.8582811951637268, green: 0.8582811951637268, blue: 0.8582811951637268, alpha: 1)
    	)
	}

	static var white: Color {
    	return color(
        	dark: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        	light: UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    	)
	}
}

extension Colors {

    static func color(dark: UIColor, light: UIColor) -> Color {
        guard #available(iOS 13, *) else { return Color(light) }
        
        return Color(UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            switch UITraitCollection.userInterfaceStyle {
            case .dark: return dark
            case .light: return light
            default: return light
            }
        })
    }
}
