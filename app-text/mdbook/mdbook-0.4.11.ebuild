# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.3.2

EAPI=7

CRATES="
	aho-corasick-0.7.18
	ammonia-3.1.1
	ansi_term-0.11.0
	anyhow-1.0.40
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.2.1
	block-buffer-0.7.3
	block-buffer-0.9.0
	block-padding-0.1.5
	byte-tools-0.3.1
	byteorder-1.4.3
	bytes-1.0.1
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	cpufeatures-0.1.1
	ctor-0.1.20
	difference-2.0.0
	digest-0.8.1
	digest-0.9.0
	either-1.6.1
	elasticlunr-rs-2.3.11
	env_logger-0.7.1
	fake-simd-0.1.2
	filetime-0.2.14
	fnv-1.0.7
	form_urlencoded-1.0.1
	fsevent-0.4.0
	fsevent-sys-2.0.1
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futf-0.1.4
	futures-0.3.14
	futures-channel-0.3.14
	futures-core-0.3.14
	futures-io-0.3.14
	futures-macro-0.3.14
	futures-sink-0.3.14
	futures-task-0.3.14
	futures-util-0.3.14
	generic-array-0.12.4
	generic-array-0.14.4
	getopts-0.2.21
	getrandom-0.1.16
	getrandom-0.2.2
	gitignore-1.0.7
	glob-0.3.0
	h2-0.3.3
	handlebars-4.0.0
	hashbrown-0.9.1
	headers-0.3.4
	headers-core-0.2.0
	heck-0.3.2
	hermit-abi-0.1.18
	html5ever-0.25.1
	http-0.2.4
	http-body-0.4.2
	httparse-1.4.0
	httpdate-1.0.1
	humantime-1.3.0
	hyper-0.14.11
	idna-0.2.3
	indexmap-1.6.2
	inotify-0.7.1
	inotify-sys-0.1.5
	input_buffer-0.4.0
	iovec-0.1.4
	itoa-0.4.7
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.94
	log-0.4.14
	mac-0.1.1
	maplit-1.0.2
	markup5ever-0.10.1
	markup5ever_rcdom-0.1.0
	matches-0.1.8
	memchr-2.4.0
	mime-0.3.16
	mime_guess-2.0.3
	mio-0.6.23
	mio-0.7.13
	mio-extras-2.0.6
	miow-0.2.2
	miow-0.3.7
	net2-0.2.37
	new_debug_unreachable-1.0.4
	notify-4.0.16
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	opaque-debug-0.2.3
	opaque-debug-0.3.0
	open-1.7.0
	output_vt100-0.1.2
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.8.0
	phf_shared-0.8.0
	pin-project-1.0.7
	pin-project-internal-1.0.7
	pin-project-lite-0.2.6
	pin-utils-0.1.0
	ppv-lite86-0.2.10
	precomputed-hash-0.1.1
	pretty_assertions-0.6.1
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.26
	pulldown-cmark-0.7.2
	quick-error-1.2.3
	quick-error-2.0.1
	quote-1.0.9
	rand-0.7.3
	rand-0.8.3
	rand_chacha-0.2.2
	rand_chacha-0.3.0
	rand_core-0.5.1
	rand_core-0.6.2
	rand_hc-0.2.0
	rand_hc-0.3.0
	rand_pcg-0.2.1
	redox_syscall-0.2.8
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	ryu-1.0.5
	same-file-1.0.6
	scoped-tls-1.0.0
	select-0.5.0
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.125
	serde_derive-1.0.125
	serde_json-1.0.64
	serde_urlencoded-0.7.0
	sha-1-0.8.2
	sha-1-0.9.5
	shlex-1.0.0
	siphasher-0.3.5
	slab-0.4.3
	socket2-0.4.0
	string_cache-0.8.1
	string_cache_codegen-0.5.1
	strsim-0.8.0
	strum-0.18.0
	strum_macros-0.18.0
	syn-1.0.72
	tempfile-3.2.0
	tendril-0.4.2
	termcolor-1.1.2
	textwrap-0.11.0
	time-0.1.43
	tinyvec-1.2.0
	tinyvec_macros-0.1.0
	tokio-1.9.0
	tokio-macros-1.3.0
	tokio-stream-0.1.7
	tokio-tungstenite-0.13.0
	tokio-util-0.6.7
	toml-0.5.8
	tower-service-0.3.1
	tracing-0.1.26
	tracing-core-0.1.18
	try-lock-0.2.3
	tungstenite-0.12.0
	typenum-1.13.0
	ucd-trie-0.1.3
	unicase-2.6.0
	unicode-bidi-0.3.5
	unicode-normalization-0.1.17
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.2.2
	url-2.2.2
	utf-8-0.7.6
	vec_map-0.8.2
	version_check-0.9.3
	walkdir-2.3.2
	want-0.3.0
	warp-0.3.1
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	which-4.1.0
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	ws2_32-sys-0.2.1
	xml5ever-0.16.1
"

inherit cargo

DESCRIPTION="Creates a book from markdown files"
HOMEPAGE="https://github.com/rust-lang/mdBook"
SRC_URI="https://github.com/rust-lang/mdBook/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/mdbook"

src_prepare() {
	eapply_user

	mv ../mdBook-${PV}/{.,}* .
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
}
