# portfolio
```
    Get-ChildItem -Filter *.elm | ForEach-Object {
    $name = $_.BaseName
    New-Item -ItemType Directory -Force -Path $name
    elm make $_.Name --output="$name\index.html"}
```

