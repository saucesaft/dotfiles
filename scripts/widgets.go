package main

import (
	"fmt"
	"time"
    	"image"
	_"embed"
	"image/color"
	"strings"
	
	"golang.org/x/image/font"
	bdf"github.com/zachomedia/go-bdf"

	"github.com/hajimehoshi/ebiten/v2"
	"github.com/hajimehoshi/ebiten/v2/text"
	util"github.com/hajimehoshi/ebiten/v2/ebitenutil"

	"github.com/yohamta/furex/v2"
	"github.com/yohamta/furex/v2/components"

	"github.com/distatus/battery"
)

/*
#cgo CFLAGS: -x objective-c
#cgo LDFLAGS: -framework AppKit
#import <AppKit/AppKit.h>

id CGSCopyManagedDisplaySpaces(int conn);
int _CGSDefaultConnection();
id CGSCopyWindowsWithOptionsAndTags(int conn, unsigned owner, NSArray *spids, unsigned options, unsigned long long *setTags, unsigned long long *clearTags);

void exclude_from_dock() {
    [NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
}

CGFloat dockHeight() {
    // get the screen
    NSScreen *screen = [NSScreen mainScreen];
    NSRect visibleFrame = [screen visibleFrame];
    NSRect screenFrame = screen.frame;

    CGFloat dockHeight = screenFrame.size.height - visibleFrame.size.height;
    return dockHeight;
}

NSUInteger desktop_num() {
    int conn = _CGSDefaultConnection();
    NSArray *info = CGSCopyManagedDisplaySpaces(conn);

    // NSNumber *spaceID = info[];

    // NSLog(@"space info: %@", [info[0][@"Spaces"] count] );
    return [info[0][@"Spaces"] count];
}


NSUInteger current_desktop() {
    int conn = _CGSDefaultConnection();
    NSArray *info = CGSCopyManagedDisplaySpaces(conn);

    // create a mutable array
    NSMutableArray *allSpaces = [NSMutableArray array];
    // iterate over the spaces
    for (NSDictionary *space in info[0][@"Spaces"]) {
	// add the space to the array
	[allSpaces addObject:space];
    }

    // get the current space id
    NSNumber *currSpaceID = info[0][@"Current Space"][@"ManagedSpaceID"];

    // iterate over allSpaces
    NSUInteger index = 0;
    for (NSDictionary *space in allSpaces) {
	// variable equal to the space id
	NSNumber *spaceID = space[@"ManagedSpaceID"];

	// NSLog(@"space id: %@", spaceID);
	// NSLog(@"current space id: %@", currSpaceID);

	// if the space id is equal to the current space id
	if ([currSpaceID isEqualToNumber:spaceID]) {
	    return index+1;
	}
	
	index++;

    }
    
    return -1;

    // NSNumber *spaceID = info[];

    // NSLog(@"space info: %@", info[0][@"Spaces"] );
}

*/
import "C"

//go:embed cherry-13-r.bdf
var fontBytes []byte

type App struct {
	init   bool
	screen screen
	gameUI *furex.View
	font   font.Face

	x, y, w, h, border, gaps float64
}

type screen struct {
	Width  int
	Height int
}

func (g *App) Update() error {
	if !g.init {
		g.init = true
		g.setupUI()
	}
	g.gameUI.Update()
	return nil
}

func (g *App) Draw(screen *ebiten.Image) {
	g.gameUI.Draw(screen)
}

func (g *App) Layout(outsideWidth, outsideHeight int) (int, int) {
    
	g.screen.Width = outsideWidth
	g.screen.Height = outsideHeight

	return g.screen.Width, g.screen.Height
}

func NewApp(font font.Face) (*App, error) {
	app:= &App{font: font}
	return app, nil
}

func (a *App) setupUI() {
	C.exclude_from_dock()

	bg, _ := ParseHexColor("#0c131c")
	fg, _ := ParseHexColor("#6e6e6e")

	gapPadding := 10
	border := 3.0

	w := int( 0.25 * float64 (a.screen.Width ) ) / 2
	h := int( C.dockHeight() ) - gapPadding * 2

	x := gapPadding
	y := a.screen.Height - int(C.dockHeight()) + gapPadding

	left := &Left{font: a.font, bg: bg, fg: fg, gaps: gapPadding, border: border, w: w, h: h, x: x, y: y}

	
	a.gameUI = (&furex.View{
		Width:      a.screen.Width,
		Height:     a.screen.Height,
		Direction:  furex.Column,
		Justify:    furex.JustifySpaceBetween,
		AlignItems: furex.AlignItemCenter,
	})


	a.gameUI.AddChild(
		(&furex.View{
			Width:      left.w,
			Height:     left.h,
			Justify:    furex.JustifyCenter,
			AlignItems: furex.AlignItemCenter,
			Left:	   left.x,
			Top:      left.y,
			Position: furex.PositionAbsolute,
			Direction:    furex.Row,
			Handler: &components.Box{
			    Color: left.bg,
			},
		}).AddChild(
			&furex.View{
				Width:   0,
				Height:  0,
				Handler: left,
			},
		),
	)

	x = a.screen.Width - w
	y = a.screen.Height - int(C.dockHeight()) + gapPadding

	right := &Right{font: a.font, bg: bg, fg: fg, gaps: gapPadding, border: border, w: w, h: h, x: x, y: y}

	a.gameUI.AddChild(
		(&furex.View{
			Width:      right.w,
			Height:     right.h,
			Justify:    furex.JustifyCenter,
			AlignItems: furex.AlignItemCenter,
			Left:	   a.screen.Width-right.w-right.gaps,
			Top:      right.y,
			Position: furex.PositionAbsolute,
			Direction:    furex.Row,
			Handler: &components.Box{
			    Color: right.bg,
			},
		}).AddChild(
			&furex.View{
				Width:   0,
				Height:  0,
				Handler: right,
			},
		),
	)

}


type Right struct {
    font font.Face
    bg, fg color.Color
    gaps, w, h, x, y int
    border float64
}

func (t *Right) HandleDraw(screen *ebiten.Image, frame image.Rectangle) {

	x := float64(t.x) + t.border - float64(t.gaps)
	y := float64(t.y) + t.border
	w := float64(t.w) - t.border * 2
	h := float64(t.h) - t.border * 2

	util.DrawRect(screen, x, y, w, h, t.fg)


	x = float64(t.x) + t.border*2 - float64(t.gaps)
	y = float64(t.y) + t.border*2
	w = float64(t.w) - t.border * 4
	h = float64(t.h) - t.border * 4
    
	util.DrawRect(screen, x, y, w, h, t.bg)

	var sb strings.Builder

	for i := 0; i < int(C.desktop_num()); i++ {
	    if (int(C.current_desktop()) == int(i+1)) {
		sb.WriteString("[X]")
	    } else {
		sb.WriteString("[]")
	    }
	}

	str := fmt.Sprintf("%s", sb.String())

	DrawCenteredText(screen, t.font, str, (frame.Min.X+frame.Max.X)/2, (frame.Min.Y+frame.Max.Y)/2)
}

type Left struct {
    font font.Face
    bg, fg color.Color
    gaps, w, h, x, y int
    border float64
}

func (t *Left) HandleDraw(screen *ebiten.Image, frame image.Rectangle) {

	x := float64(t.x) + t.border
	y := float64(t.y) + t.border
	w := float64(t.w) - t.border * 2
	h := float64(t.h) - t.border * 2

	util.DrawRect(screen, x, y, w, h, t.fg)


	x = float64(t.x) + t.border*2
	y = float64(t.y) + t.border*2
	w = float64(t.w) - t.border * 4
	h = float64(t.h) - t.border * 4
    
	util.DrawRect(screen, x, y, w, h, t.bg)

	hour := time.Now().Format("15:04")
	bat, err := battery.Get(0)
	if err != nil {
		fmt.Println("Could not get batteries info")
		return
	}
	str := fmt.Sprintf("%s // %d%%", hour, int((bat.Current/bat.Full)*100))

	DrawCenteredText(screen, t.font, str, (frame.Min.X+frame.Max.X)/2, (frame.Min.Y+frame.Max.Y)/2)
}

func DrawCenteredText(screen *ebiten.Image, font font.Face, s string, cx, cy int) {
    bounds := text.BoundString(font, s)
    x, y := cx-bounds.Min.X-bounds.Dx()/2, cy-bounds.Min.Y-bounds.Dy()/2
    text.Draw(screen, s, font, x, y, color.White)
}

func ParseHexColor(s string) (c color.RGBA, err error) {
    c.A = 0xff
    switch len(s) {
    case 7:
        _, err = fmt.Sscanf(s, "#%02x%02x%02x", &c.R, &c.G, &c.B)
    case 4:
        _, err = fmt.Sscanf(s, "#%1x%1x%1x", &c.R, &c.G, &c.B)
        // Double the hex digits:
        c.R *= 17
        c.G *= 17
        c.B *= 17
    default:
        err = fmt.Errorf("invalid length, must be 7 or 4")

    }
    return
}

func main() {
	
	ebiten.SetFPSMode(ebiten.FPSModeVsyncOffMinimum)

	sw, sh := ebiten.ScreenSizeInFullscreen()
	ebiten.SetWindowSize(sw, sh)
    	ebiten.SetScreenTransparent(true)
	ebiten.SetWindowDecorated(false)
	ebiten.SetWindowPosition(0, 0)

	// fontFile, err := ioutil.ReadFile("cherry-13-r.bdf")
	// if err != nil {
	//     panic(err)
	// }
	font, err := bdf.Parse(fontBytes)
	if err != nil {
	    panic(err)
	}

	app, err := NewApp(font.NewFace())
	if err != nil {
		panic(err)
	}

	if err := ebiten.RunGame(app); err != nil {
		panic(err)
	}
}
