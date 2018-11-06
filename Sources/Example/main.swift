import Hyperscan

let scanner = Hyperscan()
print("かえるぴょこぴょこみぴょこぴょこ")
print(scanner.scan("かえるぴょこぴょこみぴょこぴょこ", for: "ぴ.*こ")?.matches)

print("123456789")
print(scanner.scan("123456789", for: "123")?.matches)

print("123456789")
print(scanner.scan("123456789", for: "789")?.matches)

print("abcdfabacbabac")
print(scanner.scan("abcdfabacbabac", for: "aba")?.matches)

print("うあいうえお")
print(scanner.scan("うあいうえお", for: "う")?.matches)
