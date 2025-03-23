/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   print_numbers.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: Gerardo Mtnz <dev.gmartinez@gmail.com>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/23 12:47:09 by Gerardo Mtn       #+#    #+#             */
/*   Updated: 2025/03/23 12:47:18 by Gerardo Mtn      ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
void	ft_putchar(int nu)
{
	write (1, &nu, 1);
}
void	ft_print_numbers(void)
{
	int	nu;
	nu = '0';
	while (nu <= '8')
	{
		ft_putchar(nu);
		nu++;
	}
}
int	main(void)
{
	ft_print_numbers();
	return (0);
}