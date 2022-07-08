# Advances in Collection View Layout
iOS UIKit UICollectionVIew Flow Layout / Compositional Layout, Texture, FlexLayout 기반의 레이아웃 실습

## Description
+ Flow Layout 기반 Grid 형식 레이아웃 구성
+ Flow Layout 기반 Self-Sizing Cell 레이아웃 구성
+ Compositional Layout 기반 Self-Sizing Cell 레이아웃 구성
+ Compositional Layout 기반 nested collectionView 레이아웃 구성
+ Texture 기반 Masonry 형식의 레이아웃 구성(Pinterest)
+ FlexLayout 기반 Self-Sizing Feed 형식 레이아웃 구성

## Getting Start
> UIKit, SnapKit, PinLayout, FlexLayout, Texture

## Issue
### 1. 보일러 플레이트
+ Flow Layout
  + class 기반으로 커스텀 구성하고, Item 크기를 기반으로 서로 간 intersection을 토대로 main axis에 맞추어 뷰를 구성
  + 실질적으로 delegate로 구성을 하면서 기반에 구성해야 할 코드의 양이 가장 많다
+ Compositional Layout
  + 부분을 기반으로 전체를 구성한다
  + 별도의 클래스 구성 없이 각 요소들의 크기와 feature를 구성가능하다
  + delegate 구성이 별도로 필요 없다
+ Texture
  + 콜렉션 뷰 활용에 있어서만은 FlowLayout과 별 다른 차이가 없다
  + 하지만 커스텀 뷰를 구성하는 측면에 있어서 manual 한 SnapKit 등의 구성과 비교했을 때, FlexBox 요소를 활용은 가능하다 - 적극적이진 않다
  + 코드량에 있어서 큰 차이를 체감하지 못했다
  + node 별로 Component를 구분지어 구성하는 점에서 마이크로 디자인 영역에 조금 더 맞춰진 듯 하다 - 선언적으로 구성되었다는 의미
  + Rx를 결합, Obj-c 기반의 레퍼런스 코드가 많다
+ FlexLayout
  + 확실히 코드량이 매우 적다
  + update / init 시점에서 뷰의 레이아웃 구성을 보다 간단하게 할 수 있으며 PinLayout을 활용한다면 더 편리해진다
  + 추상화의 단계가 전 보다는 높아져 간결해진 코드가 많다

### 2. self-sizing
+ Flow Layout
  + 각 요소를 순회하면서 직접적으로 사이즈에 대한 값을 체크하고 뷰를 새로 고침 해주어야 한다
+ Compositional Layout
  + 편-리!, .estmated size의 소중함을 깨닫자
+ Texture
  + layoutSpecThatFits의 활용으로 그나마 적용 가능한 수준
  + 레이아웃과 사이징에 있어서는 확실히 Container / Item의 개념으로 접근할 수 있어 용이하다
+ FlexLayout
  + update 시점에서 주입되는 데이터에 따라서 flex.markDirty()의 호출을 통해서 해당 사이즈에 맞게 동기화가 가능하다
  + grow/shirink, justify/asign 등의 Container / Item 관계 설정을 보다 확실하게 하여 구성이 가능하다

### 3. Flex 개념
+ [FlexLayout Doc](https://github.com/layoutBox/FlexLayout#documentation)</br>
+ [Texture Doc](https://texture-kr.gitbook.io/wiki/newbie-guide/flex-box)</br>
+ [Flex Container 관련 이론 정리](https://velog.io/@simoniful/CSS-CSS-Basics-5)</br>
+ [Flex Item 관련 이론 정리](https://velog.io/@simoniful/CSS-CSS-Basics-6)</br>

## KeyNote
[<img src = "https://user-images.githubusercontent.com/75239459/177723619-801d8ba6-7ab4-4bff-8f24-8e2fa62df078.png" width = 400>](https://www.notion.so/sseungmn/Advances-in-Collection-View-Layout-bc396976d4d5471aa6ff665b523bf556#dc2f400f99094bdab5b722496e7c283a)

## References
+ [Compositional Layout Example from Apple Sample Code](https://inuplace.tistory.com/1038)
+ [Compositional Layout Basics](https://engineering.nodesagency.com/categories/ios/2020/01/10/Compositional-Layout-Part1)
+ [Compositional Layout concept](https://ios-development.tistory.com/945)
+ [Texture Doc](https://github.com/TextureGroup/Texture)
+ [How to use FlexLayout effectively & Sunsetting Texture](https://medium.com/daangn/how-to-use-flexlayout-effectively-sunsetting-texture-asyncdisplaykit-ca7e3f5c8441)
+ [FlexLayout Doc](https://github.com/layoutBox/FlexLayout)