# -------------------------------------------------------------------
# Script: Analisador de Conexões e Portas Suspeitas
# Autor: Rodrigo Yakuwa[cite: 1]
# Objetivo: Identificar conexões ativas em portas críticas de segurança
# -------------------------------------------------------------------

Clear-Host
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "   AUDITORIA DE SEGURANÇA: CONEXÕES DE REDE ATIVAS       " -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "Verificando conexões no sistema..." -ForegroundColor Yellow

# Lista de portas críticas conhecidas e seus serviços
$portasCriticas = @{
    21   = "FTP (Inseguro)"
    22   = "SSH"
    23   = "Telnet (Inseguro - Texto Claro)"
    80   = "HTTP (Não criptografado)"
    139  = "NetBIOS / SMB (Alvo de Ransomware)"
    445  = "SMB (Alvo de Ransomware / EternalBlue)"
    3389 = "RDP (Remote Desktop - Vetor de Força Bruta)"
}

# Obtém as conexões TCP ativas do sistema
$conexoes = Get-NetTCPConnection -State Listen, Established -ErrorAction SilentlyContinue

$alertas = 0

foreach ($conexao in $conexoes) {
    $portaLocal = $conexao.LocalPort
    
    # Verifica se a porta local está na nossa lista de monitoramento crítico
    if ($portasCriticas.ContainsKey($portaLocal)) {
        $serviço = $portasCriticas[$portaLocal]
        $ipRemoto = $conexao.RemoteAddress
        $estado   = $conexao.State
        
        Write-Host "[ALERTA] Alvo detectado na porta $portaLocal ($serviço) | Status: $estado | IP Remoto: $ipRemoto" -ForegroundColor Red
        $alertas++
    }
}

if ($alertas -eq 0) {
    Write-Host "`n[SUCESSO] Nenhuma conexão suspeita detectada nas portas críticas monitoradas." -ForegroundColor Green
} else {
    Write-Host "`n[ATENÇÃO] Varredura concluída. Encontrados $alertas pontos de atenção para auditoria." -ForegroundColor Orange
}
Write-Host "=========================================================" -ForegroundColor Cyan
