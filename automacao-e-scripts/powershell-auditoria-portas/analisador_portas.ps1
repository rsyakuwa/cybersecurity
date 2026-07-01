# === CONFIGURAÇÃO DO ARQUIVO DE LOG ===
$CaminhoLog = "C:\DLP-Quarentena\auditoria_conexoes.log"

function Registrar-Log ($Mensagem) {
    $DataHora = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    "[ $DataHora ] $Mensagem" | Add-Content -Path $CaminhoLog
}

# Inicializa o arquivo de log limpando registros anteriores
"=== INÍCIO DO LOG DE AUDITORIA DE REDE ===" | Out-File -FilePath $CaminhoLog -Force

Clear-Host
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "     AUDITORIA DE SEGURANÇA: CHECKLIST DE PORTAS CRÍTICAS" -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "Escaneando portas e conexões ativas..." -ForegroundColor Gray

# Mapeamento de portas críticas
$portasCriticas = @{
    21   = "FTP (Inseguro)"
    22   = "SSH (Acesso Remoto)"
    23   = "Telnet (Inseguro)"
    80   = "HTTP (Não Criptografado)"
    139  = "NetBIOS (Ransomware)"
    445  = "SMB (Ransomware/EternalBlue)"
    3389 = "RDP (Vetor Força Bruta)"
}

# Coleta TODAS as conexões ativas da máquina uma única vez para ganhar performance
$conexoesAtivas = Get-NetTCPConnection -State Listen, Established -ErrorAction SilentlyContinue

# Criando a lista que SEMPRE será exibida pelo Format-Table
$ResultadosTabela = @()
$TotalAlertas = 0

# Passa por cada uma das portas que queremos auditar
foreach ($Porta in $portasCriticas.Keys) {
    $Servico = $portasCriticas[$Porta]
    
    # Verifica se a porta atual está sendo usada em alguma conexão ativa
    $conexaoEncontrada = $conexoesAtivas | Where-Object { $_.LocalPort -eq $Porta }

    if ($conexaoEncontrada) {
        # Se achou a porta aberta, adiciona o alerta na tabela
        foreach ($con in $conexaoEncontrada) {
            $ResultadosTabela += [PSCustomObject]@{
                "Porta"         = $Porta
                "Serviço/Risco" = $Servico
                "Status Rede"   = $con.State
                "IP Remoto"     = $con.RemoteAddress
                "Resultado"     = "⚠️ ALERTA"
            }
            $TotalAlertas++
            Registrar-Log "ALERTA: Porta=$Porta | Serviço=$Servico | Status=$($con.State) | IP_Remoto=$($con.RemoteAddress)"
        }
    } else {
        # Se a porta estiver fechada/segura, também adiciona na tabela para prestar contas
        $ResultadosTabela += [PSCustomObject]@{
            "Porta"         = $Porta
            "Serviço/Risco" = $Servico
            "Status Rede"   = "Inativa"
            "IP Remoto"     = "-"
            "Resultado"     = "✅ Seguro"
        }
    }
}

Write-Host "`n=== RELATÓRIO FINAL DE CONFORMIDADE ===" -ForegroundColor Cyan

# O Format-Table AGORA RODA SEMPRE, exibindo o checklist completo!
$ResultadosTabela | Format-Table -AutoSize

# Exibe o resumo final com base nos alertas encontrados
if ($TotalAlertas -gt 0) {
    Write-Host "[ATENÇÃO] Varredura concluída. Encontrados $TotalAlertas pontos de atenção que necessitam de Hardening." -ForegroundColor Yellow
    Write-Host "Relatório detalhado salvo em: $CaminhoLog" -ForegroundColor Gray
} else {
    Write-Host "[SUCESSO] Ambiente em conformidade! Nenhuma vulnerabilidade exposta nas portas monitoradas." -ForegroundColor Green
    Registrar-Log "RESULTADO: Nenhuma atividade suspeita detectada. Todas as portas críticas estão protegidas."
}

Write-Host "=========================================================" -ForegroundColor Cyan
Registrar-Log "=== FIM DO LOG DE AUDITORIA DE REDE ==="
