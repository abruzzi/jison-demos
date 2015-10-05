### jison demos

There are 3 demos listing here:

1.  *calc* is a simple Calculator
2.  *mapfile* is a parser for mapfile in [Mapserver](http://mapserver.org/)
3.  *shopping* is a parser for a very simple statement but in a specified form

#### Example of a `mapfile`

```
LAYER
  NAME         "counties"
  DATA         "counties-in-shaanxi-3857"
  STATUS       "default"
  TYPE         "POLYGON"
  TRANSPARENCY 70

  CLASS
    NAME       "polygon"
    STYLE
      COLOR     255 255 255
      OUTLINECOLOR 40 44 52
    END
  END
END
```

#### Example of a `shpping` list

```
1 book at 12.49
1 "music CD" at 14.99
1 "chocolate bar" at 0.85
1 bottle of perfume at 18.99
1 packet of "headache pills" at 9.75
1 imported bottle of perfume at 27.99
1 box of imported chocolates at 11.25
```
