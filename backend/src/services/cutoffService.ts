import { DateTime } from 'luxon';

export class CutoffService {
  private static CUTOFF_HOUR_IST = 19; // 7:00 PM IST

  public static validateCancellationWindow(deliveryDate: Date): { allowed: boolean; message: string } {
    const nowIST = DateTime.now().setZone('Asia/Kolkata');
    const targetDeliveryIST = DateTime.fromJSDate(deliveryDate).setZone('Asia/Kolkata').startOf('day');
    
    const cutoffDeadlineIST = targetDeliveryIST.minus({ days: 1 }).set({
      hour: this.CUTOFF_HOUR_IST,
      minute: 0,
      second: 0,
      millisecond: 0
    });

    if (nowIST > cutoffDeadlineIST) {
      return {
        allowed: false,
        message: "Cancellation window closed for tomorrow's delivery. Cutoff rule is 7:00 PM IST on the previous day."
      };
    }

    return { allowed: true, message: "Cancellation approved." };
  }
}
