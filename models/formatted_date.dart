class FormattedDate {
  final List months = ["January", "Febuary", "March", "April", "May", "June",
   "July", "August", "September", "October", "November", "December"];
  final List weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
   "Saturday", "Sunday"];

  formatDate () {
    DateTime now = DateTime.now();
    var month = months[now.month - 1];
    var weekday = weekdays[now.weekday - 1];
    String formattedDate = "$weekday $month " + 
      "${now.day.toString().padLeft(2,'0')}, ${now.year.toString()}";
    return formattedDate;
  }
  
}