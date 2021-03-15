#impotamos modulo Active Directory
Import-Module ActiveDirectory

#Importamos archivos con usuarios
$ADUsers = Import-Csv C:\usuarios_ad.csv -Delimiter ","

#Definimos UPN
$UPN = "laboratorio.local"

#Guardamos las OU de usuarios en una variable


#Creamos las nuevas OU
## Dado que estuve haciendo tests sobre el script deje en false la proteccion contra borrado, pueden setear a true en caso de que quieran impedir la eliminacion de las OU
New-ADOrganizationalUnit -Name "Area" -Path "DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "IT" -Path "OU=Area,DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "RRHH" -Path "OU=Area,DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Legales" -Path "OU=Area,DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Defensa" -Path "OU=Area,DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Jefatura" -Path "OU=Area,DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Grupos" -Path "DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Equipos" -Path "DC=LABORATORIO,DC=LOCAL" -ProtectedFromAccidentalDeletion $false

#Creamos los grupos que contendran a los usuarios
New-ADGroup -Name "RRHH" -Path "OU=Grupos,DC=LABORATORIO,DC=LOCAL" -SamAccountName RRHH -GroupScope Global -GroupCategory Security -Description "Miembros de Recursos humanos" -DisplayName "Recursos humanos"
New-ADGroup -Name "Legales" -Path "OU=Grupos,DC=LABORATORIO,DC=LOCAL" -SamAccountName Legales -GroupScope Global -GroupCategory Security -Description "Miembros de area legal" -DisplayName "Legales"
New-ADGroup -Name "IT" -Path "OU=Grupos,DC=LABORATORIO,DC=LOCAL" -SamAccountName IT -GroupScope Global -GroupCategory Security -Description "Miembros del departamento de sistemas" -DisplayName "Sistemas"
New-ADGroup -Name "Defensa" -Path "OU=Grupos,DC=LABORATORIO,DC=LOCAL" -SamAccountName Defensa -GroupScope Global Defensa -GroupCategory Security -Description "Miembros de departamento de Defensa" -DisplayName "Departamento de defensa"
New-ADGroup -Name "Jefatura" -Path "OU=Grupos,DC=LABORATORIO,DC=LOCAL" -SamAccountName Jefatura -GroupScope Global Jefatura -GroupCategory Security -Description "Miembros de Jefatura" -DisplayName "Jefatura"



#Recorremos array de usuarios
foreach ($user in $ADUsers) {
    
    #Asignamos valor del csv a las variables correspondientes
    $username = $user.username
    $password = $user.password
    $firstname = $user.firstname
    $lastname = $user.lastname
    $initials = $user.initials
    $OU = $user.ou
    $email = $user.email
    $computer = $user.computer
    $group = $user.group

#chequeo si el usuario existe en AD
if (Get-ADUser -F {SamAccountName -eq $username}){
    #Notificamos que el usuario ya existe en el directorio activo
    Write-Warning "El usuario $username ya existe en Active Directory"
    }
else {
    #Creamos el usuario
    New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$UPN" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Initials $initials `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path $OU `
            -EmailAddress $email `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True

        # Mostrar mensaje de usuario creado
        Write-Host "la cuenta de usuario $username ha sido creada." -ForegroundColor Cyan

        #Agregamos al usuario al grupo correspondiente
        Add-ADGroupMember -Identity $group -Members $username

        #Notificamos la accion
        Write-Host "la cuenta de usuario $username ha sido agregada al grupo $grupos." -ForegroundColor Cyan

        #Creamos el objeto computadora
        New-ADComputer -Name $computer -SAMAccountName $computer -Path "OU=Equipos,DC=LABORATORIO,DC=LOCAL"

        #Notificamos el cambio realizado
        Write-Host "El equipo $computer ha sido creado." -ForegroundColor Cyan
    }

}


Read-Host -Prompt "Presione Enter para salir"