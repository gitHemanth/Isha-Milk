import SwiftUI

struct IshaDashboardView: View {
    @State private var isCutoffPassed: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Vaisakhi SkyPark - Today's Orders")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Heritage Toned Milk")
                                .font(.headline)
                            Text("1 Packet (500ml)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("₹30.00")
                            .font(.headline)
                    }
                    Divider()

                    if isCutoffPassed {
                        Text("Cancellation window closed for tomorrow's delivery.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    Button(action: cancelOrder) {
                        Text("Cancel Order")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isCutoffPassed ? Color.gray : Color(red: 0.38, green: 0.38, blue: 0.38))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(isCutoffPassed)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea())
            .navigationTitle("Isha Milk Lines")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func cancelOrder() {
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        
        // Enforce 7:00 PM IST Cutoff Rule
        if hour >= 19 {
            isCutoffPassed = true
            alertMessage = "Cancellation window closed for tomorrow's delivery. Cutoff rule is 7:00 PM IST."
            showAlert = true
        } else {
            alertMessage = "Order ORD-98765 cancelled successfully."
            showAlert = true
        }
    }
}
