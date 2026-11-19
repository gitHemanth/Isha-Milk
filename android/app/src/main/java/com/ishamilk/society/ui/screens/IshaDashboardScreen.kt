package com.ishamilk.society.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun IshaDashboardScreen(
    onCancelOrderClicked: (String) -> Unit,
    isCutoffPassed: Boolean
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
            .padding(16.dp)
    ) {
        Text(
            text = "Vaisakhi SkyPark Deliveries",
            style = MaterialTheme.typography.headlineMedium,
            color = Color(0xFF212121)
        )
        
        Spacer(modifier = Modifier.height(16.dp))

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .shadow(8.dp, RoundedCornerShape(16.dp))
                .background(Color.White, RoundedCornerShape(16.dp))
                .padding(20.dp)
        ) {
            Column {
                Text(text = "1x Heritage Toned Milk (500ml)", style = MaterialTheme.typography.titleMedium)
                Text(text = "1x Visakha Curd (500g)", style = MaterialTheme.typography.bodyMedium)

                Spacer(modifier = Modifier.height(16.dp))

                if (isCutoffPassed) {
                    Text(
                        text = "Cancellation window closed for tomorrow's delivery (7:00 PM IST Cutoff Passed).",
                        color = Color(0xFFD32F2F),
                        style = MaterialTheme.typography.bodySmall
                    )
                }

                Button(
                    onClick = { onCancelOrderClicked("ORD-98765") },
                    enabled = !isCutoffPassed,
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color(0xFF616161),
                        disabledContainerColor = Color.LightGray
                    ),
                    modifier = Modifier.align(Alignment.End)
                ) {
                    Text("Cancel Delivery", color = Color.White)
                }
            }
        }
    }
}
