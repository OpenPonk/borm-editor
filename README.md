# OpenPonk: BORM Editor

[![Nightly](https://github.com/OpenPonk/borm-editor/actions/workflows/nightly.yml/badge.svg)](https://github.com/OpenPonk/borm-editor/actions/workflows/nightly.yml) [![Coverage Status](https://coveralls.io/repos/github/OpenPonk/borm-editor/badge.svg?branch=master)](https://coveralls.io/github/OpenPonk/borm-editor?branch=master)

Diagram editor, BormLang textual DSL, and token-based simulator for [BORM](https://ccmi.fit.cvut.cz/methodologies/borm/) Object Relation Diagrams (ORD) in the [OpenPonk](https://openponk.org) modeling platform. Uses [`borm-model`](https://github.com/OpenPonk/borm-model) for the domain metamodel.

## Download

Download pre-built portable archives from [Releases](https://github.com/OpenPonk/borm-editor/releases), or get the all-in-one build at [openponk.org/#download](https://openponk.org/#download).

## Installation

See [openponk.org/#direct-installation](https://openponk.org/#direct-installation) for the supported Pharo version.

```smalltalk
Metacello new
	baseline: 'OpenPonkBormEditor';
	repository: 'github://OpenPonk/borm-editor';
	load.
```

## Documentation

Part of the [OpenPonk](https://openponk.org) platform. For architecture, the repository catalog, and contributing guidelines, see [`OpenPonk/.github`](https://github.com/OpenPonk/.github/blob/main/profile/README.md).
