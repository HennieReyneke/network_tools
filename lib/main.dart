/*import 'dart:io';

main() {
  //Process.run('ls', ['/system/bin']).then((ProcessResult results) {
  //Process.run('cat', ['--help']).then((ProcessResult results) {
  ///Process.run('ping', ['-c 3', 'google.com']).then((ProcessResult results) {
  //Process.run('netstat', ['-e']).then((ProcessResult results) {
  //Process.run('netstat', ['-r']).then((ProcessResult results) {
  //Process.run('netstat', ['-a']).then((ProcessResult results) {
  ///Process.run('ifconfig', ['-a']).then((ProcessResult results) {
  //Process.run('hostname', []).then((ProcessResult results) {
  ///Process.run('ip', ['link']).then((ProcessResult results) {
  ///Process.run('ip', ['route']).then((ProcessResult results) {
  //Process.run('ip', ['--help']).then((ProcessResult results) {
  ///Process.run('ip', ['address']).then((ProcessResult results) {
  Process.run('whoami', []).then((ProcessResult results) {
    print('stdout=${results.stdout}');
    print('stderr=${results.stderr}');
    print('exitCode=${results.exitCode}');
  });
}*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'consts.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Network Tools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Network Tools'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> data;
  String command;
  String option1;
  String option2;
  String target;
  String extra;
  TextEditingController _contCommand;
  TextEditingController _contOption1;
  TextEditingController _contOption2;
  TextEditingController _contTarget;
  TextEditingController _contExtra;
  int exitCode;
  String stdOut;
  String stdErr;

  @override
  void initState() {
    _contCommand = TextEditingController();
    _contOption1 = new TextEditingController();
    _contOption2 = new TextEditingController();
    _contTarget = new TextEditingController();
    _contExtra = new TextEditingController();
    command = '';
    option1 = '';
    option2 = '';
    target = '';
    extra = '';
    stdOut = '';
    stdErr = '';
    data = <Data>[
      Data('ls', '', '', '/system/bin', '', 'List contents of directory'),
      Data('cat', '', '', '/readme.txt', '', 'Show contents of a file'),
      Data('ping', '-c 3', '', 'google.com', '', 'Ping a domain name or IP'),
      Data('netstat', '-e', '', '', '', 'Show active Internet connections'),
      Data('netstat', '-r', '', '', '', 'Display routing table info'),
      Data('netstat', '-a', '', '', '', 'Find all open ports'),
      Data('ifconfig', '-a', '', '', '',
          'Show IP address assigned to the system'),
      Data('hostname', '', '', '', '', 'Show the hostname of the box'),
      Data('ip', 'link', '', '', '', 'List all netword interfaces'),
      Data('ip', 'route', '', '', '', 'Show the IP of the router'),
      Data('ip', 'address', '', '', '',
          'Show the link and address status of active interfaces'),
      Data('whoami', '', '', '', '', 'Show the current username'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(appPadding),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: buildCommands()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                width: tfWidthCommand,
                child: TextField(
                  controller: _contCommand,
                  onChanged: (val) {
                    command = val;
                  },
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                width: tfWidthOption1,
                child: TextField(
                  controller: _contOption1,
                  onChanged: (val) {
                    option1 = val;
                  },
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                width: tfWidthOption2,
                child: TextField(
                  controller: _contOption2,
                  onChanged: (val) {
                    option2 = val;
                  },
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                width: tfWidthTarget,
                child: TextField(
                  controller: _contTarget,
                  onChanged: (val) {
                    target = val;
                  },
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                padding: EdgeInsets.only(left: appPadding),
                width: tfWidthExtra,
                child: TextField(
                  controller: _contExtra,
                  onChanged: (val) {
                    extra = val;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: tfWidthCommand,
                child: Text('  Command'),
              ),
              Container(
                width: tfWidthOption1,
                child: Text('  Opt 1'),
              ),
              Container(
                width: tfWidthOption2,
                child: Text('  Opt 2'),
              ),
              Container(
                width: tfWidthTarget,
                child: Text(
                  '  Target',
                ),
              ),
              Container(
                width: tfWidthExtra,
                child: Text('  Extra'),
              ),
            ],
          ),
          RaisedButton(
              child: Text('Execute'),
              onPressed: () {
                print(
                    'command=$command,option1=$option1,option2=$option2,target=$target,extra=$extra');
                runCommand();
                print('exitCode=$exitCode');
                print('stdout=$stdOut');
                print('stderr=$stdErr');
              }),
          FlatButton(
            child: Text(
              'Add Help Option',
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () {
              option1 = '--help';
              option2 = '';
              target = '';
              extra = '';
              _contOption1.text = '--help';
              _contOption2.clear();
              _contTarget.clear();
              _contExtra.clear();
            },
          ),
          Text(
            'ExitCode:',
            style: Theme.of(context).textTheme.title,
          ),
          Container(
            width: tfWidthExitCode,
            child: Text(
              exitCode.toString() == 'null' ? '' : exitCode.toString(),
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Text(
            'StdOut:',
            style: Theme.of(context).textTheme.title,
          ),
          Container(
            width: tfWidthStdOut,
            child: Text(
              stdOut,
              style: Theme.of(context).textTheme.subtitle,
              maxLines: maxLinesStdOut,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'ErrOut:',
            style: Theme.of(context).textTheme.title,
          ),
          Container(
            width: tfWidthErrOut,
            child: Text(
              stdErr,
              style: Theme.of(context).textTheme.subtitle,
              maxLines: maxLinesErrOut,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void runCommand() {
    if (option1 == '' && option2 == '' && target == '' && extra == '') {
      Process.run(command, []).then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else if (option1 == '' && option2 == '' && extra == '') {
      Process.run(command, [target]).then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else if (option2 == '' && target == '' && extra == '') {
      Process.run(command, [option1]).then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else if (option2 == '' && extra == '') {
      Process.run(command, [option1, target]).then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else if (extra == '') {
      Process.run(command, [option1, option2, target])
          .then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else if (option2 == '') {
      Process.run(command, [option1, target, extra])
          .then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    } else {
      Process.run(command, [option1, option2, target, extra])
          .then((ProcessResult results) {
        setState(() {
          stdOut = results.stdout;
          stdErr = results.stderr;
          exitCode = results.exitCode;
        });
      });
    }
  }

  /*getResults(ProcessResult results) {
    setState(() {
      stdOut = results.stdout;
      stdErr = results.stderr;
      exitCode = results.exitCode;
    });
  }*/

  List<Widget> buildCommands() {
    List<Widget> toret = [];
    for (Data d in data) {
      toret.add(
        ListTile(
          dense: true,
          leading: Container(
            width: tWidthDesc,
            child: Text(
              d.desc,
            ),
          ),
          trailing: RaisedButton(
            child: Text('Populate'),
            onPressed: () {
              command = d.command;
              option1 = d.option1;
              option2 = d.option2;
              target = d.target;
              extra = d.extra;
              _contCommand.text = d.command;
              _contOption1.text = d.option1;
              _contOption2.text = d.option2;
              _contTarget.text = d.target;
              _contExtra.text = d.extra;
            },
          ),
        ),
      );
    }
    return toret;
  }
}
