// class Resource {
//   final String? name;
//   final String? date;
//   final List? files;

//   const Resource({
//     this.name,
//     this.date,
//     this.files,
//   });

//   factory Resource.fromJson(Map<String, dynamic> data) {
//     final name = data['name'];
//     final date = data['date'];
//     final files = data['files'];

//     return Resource(
//       date: date,
//       name: name,
//       files: files,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         ' name': name,
//         'date': date,
//         'files': files,
//       };
// }
