class Inspections {
  final String inspector, company, date, status, actions;

  Inspections(
      {required this.inspector,
      required this.company,
      required this.date,
      required this.status,
      required this.actions});
}

List<Inspections> demoInspections = [
  Inspections(
    inspector: "Ride inspector",
    company: "Ride",
    status: "Approved",
    date: "01-03-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Elias Ayele",
    company: "Ride",
    status: "pending",
    date: "01-04-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Abebe Kebede",
    company: "Ride",
    status: "Rejected",
    date: "02-02-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Bereket Tufa",
    company: "Ride",
    status: "Approved",
    date: "01-03-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Arega Addisu",
    company: "Ride",
    status: "pending",
    date: "05-05-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Sisay Animaw",
    company: "Ride",
    status: "Rejected",
    date: "01-06-2021",
    actions: "seen",
  ),
  Inspections(
    inspector: "Kaleab Goytom",
    company: "Ride",
    status: "Approved",
    date: "09-03-2021",
    actions: "seen",
  ),
];
