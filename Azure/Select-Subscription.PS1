
function Select-Subscription
{
    # Get Subscriptions
    $subOutput = Get-AzSubscription

    # Write Host Options
    Format-Table | Out-String |% {Write-Host "Index     Subscription Name             Id"}
    Format-Table | Out-String |% {Write-Host "------    -----------------             -----------------"}

    $subs = Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}
    $line = 1

    for($index=0;$index-le $subs.length-1;$index++)
        {
            $padColumn2 = " " * (28 -  $subs[$index].Name.Length)
            Format-Table | Out-String |% {Write-Host " " $line "     " $($subs[$index].Name)$padColumn2 $subs[$index].Id}
            $line++
        }

    # Get Selection
    $option = Read-Host "Enter: "
    $option_index = [int]$option - 1

    $context = Get-AzSubscription -SubscriptionId $subs[$option_index].Id
    
    # Set Subscription
    Set-AzContext $context
}