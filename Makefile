FONTS = Noto+Sans:400,400i,700,700i|Noto+Serif:400,400i,700,700i

SERVE_ARGS = --drafts -P 4000

help:
	$(info make build          - Build using jekyll)
	$(info make serve          - Run a local jekyll server)
	$(info make update-fonts   - Download updated fonts)
	$(info make clean          - Remove build directory)
	@echo

build:
	@jekyll build

serve:
	@jekyll serve

update-fonts:
	@mkdir -p assets/fonts
	@cd assets/fonts; google-font-download -o ../font.css -f woff2,woff -u \
	"https://fonts.googleapis.com/css?family=$(FONTS)"
	@cd assets; sed -i -e "s:url('Noto:url('/assets/fonts/Noto:" font.css

clean:
	@echo "Cleaning..."
	@rm -rf _site .jekyll-cache
