# BORM editor

## For non-development

```
Metacello new
	baseline: 'BormEditor';
	repository: 'github://dynacase/borm-editor/repository';
	load.
```

## For development

1. load GitFileTree

```
Gofer new
	url: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main';
	configurationOf: 'GitFileTree';
	loadDevelopment.
```

2. clone git repo

```
git clone git@github.com:dynacase/borm-editor.git my_path_to_wherever
```

3. load project (in Playground); **Do not forget to point to /repository subfolder.**

```
Metacello new
	baseline: 'BormEditor';
	repository: 'gitfiletree:///my_path_to_wherever/repository';
	load.
```

0. if you need to make changes to DynaCASE itself, you will need to make use of locks. (https://github.com/dynacase/dynacase/blob/master/README.md)
