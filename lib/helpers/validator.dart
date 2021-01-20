import 'dart:async';
import 'dart:io';

class Validator {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@")) {
//          !RegExp(r"[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//              .hasMatch(email)) {
//        sink.add(email);
      sink.add(email);
    } else {
      sink.addError('please enter valid email');
    }
  });
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 6) {
      sink.add(name);
    } else {
      sink.addError('please enter valid name');
    }
  });
  var dateValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    if (date.length > 6) {
      sink.add(date);
    } else {
      sink.addError('enter valid date');
    }
  });
  var contactListValidator =
      StreamTransformer<List<String>, List<String>>.fromHandlers(
          handleData: (contact, sink) {
    if (contact.length > 1) {
      sink.add(contact);
    } else {
      sink.addError('أدخل رقم واحد على الاقل');
    }
  });
  var nothingFile =
      StreamTransformer<File, File>.fromHandlers(handleData: (image, sink) {
    sink.add(image);
  });

  var addressValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 4) {
      sink.add(name);
    } else {
      sink.addError('اكتب العنوان كامل');
    }
  });

  var descriptionValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 10) {
      sink.add(name);
    } else {
      sink.addError('يجب ان يكون عدد الحروف للوصف يزيد عن 10 حروف');
    }
  });

  var aboutGroupValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 10) {
      sink.add(name);
    } else {
      sink.addError('يجب ان يكون عدد الحروف لتعريف المجموعه يزيد عن 10 حروف');
    }
  });

  var phoneNumberValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length > 8) {
      sink.add(num);
    } else {
      sink.addError("Enter a valid phone number");
    }
  });
  var codeValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length > 3) {
      sink.add(num);
    } else {
      sink.addError("Enter a valid code");
    }
  });

  var selectedId =
      StreamTransformer<int, int>.fromHandlers(handleData: (id, sink) {
    if (id != null) {
      sink.add(id);
    } else {
      sink.addError("من فضلك قم باختيار المدينة والمحافظة");
    }
  });

  var numberOfPeopleValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length == 0) {
      sink.add(num);
    } else {
      sink.addError('العدد يجيب علي الاقل 1');
    }
  });
  var cost =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length == 0) {
      sink.add(num);
    } else {
      sink.addError('');
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 6 character');
    }
  });

  var noThing =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    sink.add(num);
  });

  var linkValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (link, sink) {
    if (link.contains("http")) {
      sink.add(link);
    } else {
      sink.addError('يجب ان تقوم بادخال لينك بصيغة http');
    }
  });

  var test = StreamTransformer<int, int>.fromHandlers(handleData: (num, sink) {
    if (num > 0) {
      sink.add(num);
    } else {
      sink.addError('ادخل رقم اكبر من الصفر');
    }
  });

  var confirmPassWordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError('');
    }
  });
}
