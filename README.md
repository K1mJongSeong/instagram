# KeyPoint

👉Social Login
👉Firebase FCM
👉상태관리 Provider
👉Permission
👉TDD


Flutter Instagram clone
<h1>사용 기술</h1>
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=html5&logoColor=white">


<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=html5&logoColor=white">


<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=html5&logoColor=white">


<img src="https://img.shields.io/badge/Github-181717?style=for-the-badge&logo=html5&logoColor=white">


<h1>Version Upgrage Issue!!😺</h1>


|변경 전|변경 후|
|------|---|
|FlatButton|TextButton|
<pre><code>TextButton(
  onPressed: () {
      // Respond to button press
  },
  child: Text("TEXT BUTTON"),
)
TextButton.icon(
  onPressed: () {
      // Respond to button press
  },
  icon: Icon(Icons.add, size: 18),
  label: Text("TEXT BUTTON"),
)</code></pre>
기존의 Flat Button에서 style문법이 변화했다.

<pre><code>FlatButton(
  textColor: Colors.red, // foreground
  onPressed: () { },
  child: Text('FlatButton with custom foreground/background'),
)
TextButton(
  style: TextButton.styleFrom(
    primary: Colors.red, // foreground
  ),
  onPressed: () { },
  child: Text('TextButton with custom foreground'),
)</code></pre>


|변경 전|변경 후|
|------|---|
|Outline Button|OutlinedButton|
<pre><code>OutlinedButton(
  onPressed: () {
      // Respond to button press
  },
  child: Text("OUTLINED BUTTON"),
)
OutlinedButton.icon(
  onPressed: () {
      // Respond to button press
  },
  icon: Icon(Icons.add, size: 18),
  label: Text("OUTLINED BUTTON"),
)</code></pre>


|변경 전|변경 후|
|------|---|
|RaisedButton |ElevatedButton|
<pre><code>ElevatedButton(
  onPressed: () {
      // Respond to button press
  },
  child: Text('CONTAINED BUTTON'),
)
ElevatedButton.icon(
  onPressed: () {
      // Respond to button press
  },
  icon: Icon(Icons.add, size: 18),
  label: Text("CONTAINED BUTTON"),
)</code></pre>
기존의 RaisedButton와 style 문법이 차이가 난다.


<pre><code>RaisedButton(
  color: Colors.red, // background
  textColor: Colors.white, // foreground
  onPressed: () { },
  child: Text('RaisedButton with custom foreground/background'),
)
ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Colors.red, // background
    onPrimary: Colors.white, // foreground
  ),
  onPressed: () { },
  child: Text('ElevatedButton with custom foreground/background'),
)</code></pre>
