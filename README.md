
![Header image](header.png)

# Visual Debug Tools
Visual Debug Tools is a set of small utility tools for SwiftUI that let you visually debug your views while building them. 

# Installation
Visual Debug Tools are available through SPM. 
```
https://github.com/heyrodrigo/visual-debug-tools
```

# Usage
To visually debug a view just add the view modifier `.debug()`. This will show the views bounds and size.

```swift
struct DemoView: View {
    var body: some View {
        Text("Visual Debug Tools")
            .font(.largeTitle)
            .debug()
    }
}
```

# Author
Rigo Rigo AB.
